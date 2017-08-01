# Tamashii環境安裝 (for Ubuntu)

**Ruby 2.4.1**

[guide](https://gorails.com/setup/ubuntu/16.04)


**PostgrSQL 9.5+**
[follow the PostgreSQL section](https://gorails.com/setup/ubuntu/16.04)
(https://www.postgresql.org/download/linux/ubuntu/)

**Redis**
[guide](https://redis.io/topics/quickstart)

**Node.js (4.3.0)** 
[guide](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)
[other version](http://oranwind.org/-node-js-ubuntu-shi-yong-nvm-an-zhuang-node-js-lts/)
*Yarn*
[guide](https://yarnpkg.com/lang/en/docs/install/)

---
**Run Tamashii locally**
(After cloning the Tamashii project you want to use)

Go to the project folder, in the terminals:

``` 
$ redis-server
```

```
$ yarn ##only need to run this at first time 
$ bin/webpack-dev-server
```

```
$ rails s
```
(these terminals should be running while you are using Tamashii)

go to `localhost:3000`, should see the webpage.

---

**Adding a user the first time**
You will need to create a user first in order to log into Tamashii.
In the terminal, run the rails console `rails c`
```
> User.create(name: "your_name", email:"mail", password:"pass", admin: true) //set admin to true so you can manage others accounts
> User.all()  //check all the users in the database
```

---
**Setting up machine and connect**

(for setting up the first time: copy ".env.example" file in the tamashii project folder and rename it to .env)

1. Connect your machine to the computer and turn it on.

2. Go to [this website](http://people.cs.nctu.edu.tw/~lctseng/pi/ip_record.txt) (user: 5xruby, password: yburx5) and find the correspnded machine(by compring the time and serial number), copy down its IP address

3. Check your IP address (ifconfig)
4. Change the host IP setting in the machine:
```
> ssh pi@machine_ip //password: raspberry
[XD]% sudo nano /etc/tamashii-agent-config.rb
Update the host IP to your IP address （remember to 寫入）
[XD]% sudo systemctl restart tamashii-agent
[XD]% exit
```