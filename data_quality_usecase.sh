#!/bin/sh

#docker run -it --name data_quality_python --rm -v ~/docker/kraken/NCATS-Translator-DQA/ncats_translator_dqa:/usr/src/myapp -w /usr/src/myapp python:3 python translator_dqa.py -f "https://fairsharing.org/biodbcore-000663"

docker run -it --name data_quality_python --rm -v ~/NCATS-Translator-DQA/ncats_translator_dqa:/usr/src/myapp -w /usr/src/myapp python:3 python translator_dqa.py -f "https://fairsharing.org/biodbcore-000663"


#first we build the image
docker build -t translator_dqa .

#then we run
docker run -it --rm -p 7200:7200  -v /data/dqainput/:/root/NCATS-Translator-DQA/Input/ -v /data/dqaoutput:/root/NCATS-Translator-DQA/Output/ translator_dqa -h


#trying without volume
docker run -it --rm -p 7200:7200 translator_dqa -h

# 
docker run -it --rm -p 7200:7200  -v /data/dqainput/:/root/NCATS-Translator-DQA/Input/ -v /data/dqaoutput:/root/NCATS-Translator-DQA/Output/ translator_dqa -d /root/NCATS-Translator-DQA/Input/kegg-drug.ttl
docker run -it --rm -p 7200:7200  -v /data/dqainput/:/root/NCATS-Translator-DQA/Input/ -v /data/dqaoutput:/root/NCATS-Translator-DQA/Output/ translator_dqa -d /root/NCATS-Translator-DQA/Input/kegg-drug.ttl


#when we run 
#docker run -it --rm translator_dqa -f https://biosharing.org/biodbcore-000081 -d ../Output/biodbcore-000081_rdf.ttl
#error:
Traceback (most recent call last):
  File "translator_dqa.py", line 119, in <module>
    main()
  File "translator_dqa.py", line 115, in main
    translator_dqa(args.fair_url, args.file_data, args.file_multi, args.schema)
  File "translator_dqa.py", line 64, in translator_dqa
    computational_metrics(file_data, schema)
  File "/root/NCATS-Translator-DQA/ncats_translator_dqa/computational_metrics/computational_metrics.py", line 30, in computational_metrics
    file_rdfunit_output = rdfunit.rdfunit(file_dataset, schema)
  File "/root/NCATS-Translator-DQA/ncats_translator_dqa/computational_metrics/RDFUnitWrapper.py", line 41, in rdfunit
    stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='UTF-8', cwd=self.path_rdfunit)
  File "/usr/local/lib/python3.5/subprocess.py", line 383, in run
    with Popen(*popenargs, **kwargs) as process:
TypeError: __init__() got an unexpected keyword argument 'encoding'


#if we run in the original repo
cd \
cd NCATS-Translator-DQA \
export PYTHONPATH=$PYTHONPATH:/Users/pedrohserrano/NCATS-Translator-DQA \
cd ncats_translator_dqa 

python translator_dqa.py -h
python translator_dqa.py -f https://biosharing.org/biodbcore-000081 #-d ../Output/biodbcore-000081_rdf.ttl
#once we have the outputfile
python translator_dqa.py -d ../Output/biodbcore-000081_rdf.ttl
#does not work
#error:AttributeError: 'module' object has no attribute 'run'
python translator_dqa.py -d chembl_18.0_cellline.ttl
#the same error

#multiple datasets defined in a csv file
python translator_dqa.py -m /home/user/data/multiple_data_sets.csv
#after the mayority of the links covered we had an error at the final
  File "translator_dqa.py", line 53, in translator_dqa
    filename = 'prelim_stats_' + datetime.now().isoformat(timespec='seconds') + '.csv'
TypeError: 'timespec' is an invalid keyword argument for this function 

## DEBUGING THE ERROR
## INSERT VOLUMES IN IMAGE