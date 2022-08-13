#!/bin/bash
# NUM_CPU_PHYSICAL_CORES=4
# Download source from github
FOOTNOTE_INFO="Build Time `date`"

#Download and build opm simulators with MPI support from git
for repo in opm-common opm-grid opm-material opm-models opm-simulators
do

    # Determine if to clone from main URL or different repo, based upon REPO_{$repo} environment variable
    echo "### "
    echo "### $repo"
    echo "### "
    repo_env_var_check=REPO_`echo "$repo" | awk '{print toupper($0)}' | sed 's/-/_/g'`
    if test -z ${!repo_env_var_check}
    then
       repo_url="https://github.com/OPM/$repo.git"
       echo "$repo_env_var_check is not set, using $repo_url"
    else
       echo "$repo_env_var_check is set to ${!repo_env_var_check}"
       repo_url=${!repo_env_var_check}
    fi

    # use the base64 of the Git URL as the basis for the directory to avoid collissions
    repo_dir=`base64 <<< "$repo_url"`
    echo "$repo directory is $repo_dir"
    if [ -d "$repo_dir" ]; then 
        pushd "$repo_dir"
        git pull
        popd
    else
        git clone $repo_url "$repo_dir"
    fi

    # Determine if checking out Git master (default) or some other point based upon REPO_{$repo}_CHECKOUT environment variable
    git_checkout_env_var_check=${repo_env_var_check}_CHECKOUT
    if test -z ${!git_checkout_env_var_check}
    then
    	repo_checkout="master"
        echo "$git_checkout_env_var_check is not set, checking out $repo_checkout"
        pushd "$repo_dir"
        git checkout $repo_checkout
        popd
    elif [[ "${!git_checkout_env_var_check}" =~ ^[0-9]+$ ]]
    then
    	repo_checkout=${!git_checkout_env_var_check}
        echo "$git_checkout_env_var_check is a number, assuming it's a GitHub pull request - ${!git_checkout_env_var_check}"
        pushd "$repo_dir"
	git pull --no-edit origin pull/${!git_checkout_env_var_check}/head
        popd
    else
    	repo_checkout=${!git_checkout_env_var_check}
        echo "$git_checkout_env_var_check is set, checking out ${!git_checkout_env_var_check}"
        pushd "$repo_dir"
        git checkout $repo_checkout
        popd
    fi

   # symlinks for the default directory to the BASE64'd directories intended for this round of testing
   unlink $repo
   ln -s "$repo_dir" $repo

    mkdir "$repo_dir"/build
    pushd "$repo_dir"/build
    make clean
    cmake -DCMAKE_BUILD_TYPE=Release -DUSE_MPI=ON -DBUILD_TESTING=OFF ..
    make -j $NUM_CPU_PHYSICAL_CORES 
    ecode=$?
    echo $? > ~/install-exit-status
    test $? -eq 0 || exit 1
    popd
done

echo $FOOTNOTE_INFO > ~/install-footnote

# SETUP OMEGA IF PRESENT
if test -f $HOME/omega-opm-2.tar.gz
then
  git clone --depth 1 https://github.com/OPM/opm-data.git
  pushd opm-data
  tar -xf ~/omega-opm-2.tar.gz
  popd
fi

cd opm-data
tar -xf ~/Norne-4C.tar.gz
cd ~
tar -xf opm-benchmark-extras-1.tar.xz

#####################################################
# Run benchmark
#####################################################

echo "#!/bin/sh

NPROC=\$2

if [ ! \"X\$HOSTFILE\" = \"X\" ] && [ -f \$HOSTFILE ]
then
	HOSTFILE=\"--hostfile \$HOSTFILE\"
elif [ -f /etc/hostfile ]
then
	HOSTFILE=\"--hostfile /etc/hostfile\"
else
	HOSTFILE=\"\"
fi

MPIRUN_AS_ROOT_ARG=\"--allow-run-as-root\"
if [ \`whoami\` != \"root\" ]
then
  MPIRUN_AS_ROOT_ARG=\"\"
fi

# Check if there are Numa nodes
if lscpu | grep node1 ; then
    MPI_MAP_BY=\"--map-by numa\"
else
    MPI_MAP_BY=\"--map-by socket\"
fi

if [ \$1 = \"upscale_relperm_benchmark\" ]
then
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$NPROC \$MPI_MAP_BY --report-bindings \$HOSTFILE ./opm-upscaling/build/bin/upscale_relperm_benchmark > \$LOG_FILE 2>&1
elif [ \$1 = \"flow_mpi_norne\" ]
then
	cd opm-data/norne
	rm -f NORNE_ATW2013.SMSPEC
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$NPROC \$MPI_MAP_BY --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow NORNE_ATW2013.DATA > \$LOG_FILE 2>&1
	~/summary-parse.sh NORNE_ATW2013.SMSPEC >> \$LOG_FILE
elif [ \$1 = \"flow_mpi_norne_4c_msw\" ]
then
	cd opm-data/Norne-4C
	rm -f NORNE_ATW2013_4C_MSW.SMSPEC
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$NPROC \$MPI_MAP_BY --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow NORNE_ATW2013_4C_MSW.DATA > \$LOG_FILE 2>&1
	~/summary-parse.sh NORNE_ATW2013_4C_MSW.SMSPEC >> \$LOG_FILE
elif [ \$1 = \"flow_ebos_extra\" ]
then
	cd opm-data/omega-opm
	rm -f OMEGA-0.SMSPEC
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$NPROC \$MPI_MAP_BY --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow OMEGA-0.DATA > \$LOG_FILE 2>&1
	~/summary-parse.sh OMEGA-0.SMSPEC >> \$LOG_FILE
elif [ \$1 = \"flow_mpi_extra\" ]
then
	cd opm-data/omega-opm
	rm -f OMEGA-0.SMSPEC
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$NPROC \$MPI_MAP_BY --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow OMEGA-0.DATA > \$LOG_FILE 2>&1
	~/summary-parse.sh OMEGA-0.SMSPEC >> \$LOG_FILE
else
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$NPROC \$MPI_MAP_BY --report-bindings \$HOSTFILE opm-simulators/build/bin/flow \$1 > \$LOG_FILE 2>&1
fi

cd ~
\$PHP_BIN report-additional-data.php > ~/pts-footnote 

# echo \$? > ~/test-exit-status" > opm-git
chmod +x opm-git
