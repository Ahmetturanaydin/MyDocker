# MyDocker

1-) myuser yerine kullanmak istediğiniz kullanıcı adını yazın.

2-) .ssh dosyasının içerisine ssh key'inizi ekleyiniz.

3-) image build alalım.

docker build . -t ssh-autho

4-) containerimizi başlatalım.

docker run -dit -p 2223 --name sshkeys ssh-autho 

5-) container içine ssh key ile direkt bağlantı yapma.

ssh myuser@ip -p 2223
