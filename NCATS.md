
## Runing the container
1. First we build the image  
`docker build -t translator_dqa .`

2. Creating the container  

- Running and removing  
`docker run -it --rm -p 7200:7200  -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ translator_dqa -h` (doesn't has a direct action)
- File from url  
`docker run -it --rm -p 7200:7200  -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ translator_dqa -f https://biosharing.org/biodbcore-000015` (it runs but doesn't connect to graphdb, is not creating the ports?)
- File from directory  
`docker run -it --rm -p 7200:7200 -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ translator_dqa -d /root/NCATS-Translator-DQA/Input/kegg-drug.ttl`(encoding error)

- Maintain the container  
`docker run -it -p 7200:7200 -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ --name=dqa_box translator_dqa`
(with bash)
`docker run -it -p 7200:7200 -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ --name=dqa_box --entrypoint /bin/bash translator_dqa` 
(levanta el contenedor con un entrypoint) out of the container `exit`

3. Enter existing container   
`docker start -ai dqa_box`

- Same Examples/cases to run inside the container  
`python translator_dqa.py -f https://biosharing.org/biodbcore-000015`
`python translator_dqa.py -d ../Input/chembl_18.0_cellline.ttl`


~/data
kegg-drug.ttl
chembl_18.0_cellline.ttl


- When we try to run the dataset

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


- Runing from the original repo
cd \
cd NCATS-Translator-DQA \
export PYTHONPATH=$PYTHONPATH:~/NCATS-Translator-DQA \
cd ncats_translator_dqa 

python translator_dqa.py -h
python translator_dqa.py -f https://biosharing.org/biodbcore-000081 #-d ../Output/biodbcore-000081_rdf.ttl

python translator_dqa.py -d chembl_18.0_cellline.ttl
#the same error

#multiple datasets defined in a csv file
python translator_dqa.py -m /home/user/data/multiple_data_sets.csv
#after the mayority of the links covered we had an error at the final
  File "translator_dqa.py", line 53, in translator_dqa
    filename = 'prelim_stats_' + datetime.now().isoformat(timespec='seconds') + '.csv'
TypeError: 'timespec' is an invalid keyword argument for this function 

---

# NCATS Branched repo
- Is it possible to change things in the code
- Then push in to my branch
- Change/Create a second image, that downloads my branch instead the original
- Try the codeagain
- We can add nano to the docker image

I tryed take the encoding of the code in DRFUnitWraper

Check pythonb version

      File "translator_dqa.py", line 119, in <module>
        main()
      File "translator_dqa.py", line 115, in main
        translator_dqa(args.fair_url, args.file_data, args.file_multi, args.schema)
      File "translator_dqa.py", line 64, in translator_dqa
        computational_metrics(file_data, schema)
      File "/root/NCATS-Translator-DQA/ncats_translator_dqa/computational_metrics/computational_metrics.py", line 30, in computational_metrics
        file_rdfunit_output = rdfunit.rdfunit(file_dataset, schema)
      File "/root/NCATS-Translator-DQA/ncats_translator_dqa/computational_metrics/RDFUnitWrapper.py", line 47, in rdfunit
        sys.stderr.write(cp.stderr)
    TypeError: write() argument must be str, not bytes


#after fixing the compiler
chmod +x NCATS-Translator-DQA/ncats_translator_dqa/translator_dqa.py
./NCATS-Translator-DQA/ncats_translator_dqa/translator_dqa.py
#still not working the pythonpath
export PYTHONPATH=$PYTHONPATH:/Users/pedrohserrano/NCATS-Translator-DQA

export PATH=$PATH:$JAVA_HOME/bin
#python requirements
pip3 install 
requests
argparse 
#csv 
lxml 
pandas 
#subprocess 
#json
rdflib

#cd RDFUnit  
./bin/rdfunit -h
Note: rdfunit must be run from the RDFUnit folder, i.e., it fails when run from inside the bin folder or anywhere other than the RDFUnit folder.


## Resources
https://zaiste.net/posts/removing_docker_containers/
all images `docker images -q | xargs docker rmi --force`
all containers `docker ps -aq | xargs docker rm`
all system `docker system prune --all`
check ports `docker inspect $container_id | $container_name`