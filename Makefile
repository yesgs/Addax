.PHONY: default pkg ali baidu


t=$(shell date '+%Y%m%d%H%M')

repo_ali="registry.cn-shanghai.aliyuncs.com/etl/addax"
repo_baidu="registry.baidubce.com/etl/addax"


t1="${repo_ali}:${t}"
t2="${repo_baidu}:${t}"


default:
	@echo "ali baidu"


pkg:
	@echo "package"
	mvn clean package -DskipTests
	mvn package assembly:single
	./shrink_package.sh
	rm -f ./target/addax/addax-*.tar.gz

ali:
	@echo "make ali"
	sudo docker login --username=xxx registry.cn-shanghai.aliyuncs.com -p xxx
	sudo docker build -t ${t1} -f Dockerfile .
	sudo docker tag ${t1} ${repo_ali}:latest
	sudo docker push ${repo_ali}:latest

baidu:
	@echo "make baidu"
	sudo docker login --username=xxx registry.baidubce.com -p xxx
	sudo docker build -t ${t2} -f Dockerfile .
	sudo docker tag ${t2} ${repo_baidu}:latest
	sudo docker push ${repo_baidu}:latest



