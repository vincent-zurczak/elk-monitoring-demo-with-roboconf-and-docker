
1. Start the DM.
2. Configure it with RabbitMQ (you can keep the defaults settings: localhost/guest/guest).
3. Feel free to install Decanter in the DM (not mandatory).
4. Deploy the Roboconf target.

	roboconf:target docker

5. Start Elastic Search and Kibana:

	docker pull elasticsearch:5.1.1
	docker run --name rbcf-elasticsearch -p 9200:9200 -d elasticsearch
	
	docker pull kibana:5.1.1
	docker run --name rbcf-kibana --link rbcf-elasticsearch:elasticsearch -p 5601:5601 -d kibana

6. Install the web extension for Kibana.

	bundle:install --start mvn:net.roboconf/roboconf-web-extension-for-kibana/0.8-SNAPSHOT

7. Create or update etc/net.roboconf.dm.web.extension.kibana.cfg

	# The base URL for applications dashboards.
	dashboard-url-applications = http://localhost:5601/app/kibana

	# The base URL for agent dashboards.
	dashboard-url-agents = http://localhost:5601/app/kibana

7. Compile and load the Roboconf application.
8. Get to the Kibana extension page and reach the dashboards.

