FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt-get install ansible -y

CMD ["ansible-playbook", "-i", "inventory/hosts.yml", "playbooks/setup.yml"]