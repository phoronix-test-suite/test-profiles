#!/bin/sh

unzip -o master.zip
cd benchmarks-master/
mv datasets/dataset-urls.txt datasets/dataset-urls.txt.bk
cat datasets/dataset-urls.txt.bk|grep "webpage" > datasets/dataset-urls.txt
make datasets

cd ../
echo "#!/bin/sh
cd benchmarks-master/
case \$@ in
        \"SCIKIT_SVM\")
		cat test.yaml |grep -A 9 "SCIKIT_SVM" > ./SCIKIT_SVM.yaml
		sed -i -e '/oilspill_train/d' -e 's/iris/webpage/g' SCIKIT_SVM.yaml
        ;;
esac

python run.py -l SCIKIT -m SVM -c \$@.yaml > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > mlpack-benchmarks
chmod +x mlpack-benchmarks
