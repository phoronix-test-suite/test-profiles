#!/bin/sh

tar xvf scikit-learn-0.22.1.tar.gz

echo "#!/bin/sh
cd scikit-learn-0.22.1/benchmarks/

cat <<'EOF' > insert_sgd_regression

    elnet_time = elnet_results.sum(axis=(0,1))[1]
    sgd_time = sgd_results.sum(axis=(0,1))[1]
    asgd_time = asgd_results.sum(axis=(0,1))[1]
    ridge_time = ridge_results.sum(axis=(0,1))[1]
    total_time = elnet_time + sgd_time + asgd_time + ridge_time
    print(\"Final result: %fs\" % total_time)

EOF



case \$@ in
        \"RANDOM_PROJECTIONS\")
		time -p python3 bench_random_projections.py > \$LOG_FILE 2>&1
        ;;
        \"SGD_REGRESSION\")
                sed -i -e '5 s/^/\#/' -e '112, $ s/^/\#/' -e '110r insert_sgd_regression' bench_sgd_regression.py
		rm insert_sgd_regression
                python3 bench_sgd_regression.py > \$LOG_FILE 2>&1
        ;;

esac
echo \$? > ~/test-exit-status" > scikit-learn
chmod +x scikit-learn

