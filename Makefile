.PHONY: restart clean up

clean:
	docker-compose down --volumes --remove-orphans
	docker system prune -af --volumes

up:
	docker-compose up --build -d

restart: clean up
