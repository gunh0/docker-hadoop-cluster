.PHONY: up down restart wordcount clean logs build

up:
	cd docker && docker compose up -d

down:
	cd docker && docker compose down

restart:
	cd docker && docker compose restart

wordcount:
	cd docker && $(MAKE) wordcount

build:
	cd docker && $(MAKE) build

clean:
	cd docker && docker compose down -v
	docker system prune -f

logs:
	cd docker && docker compose logs -f