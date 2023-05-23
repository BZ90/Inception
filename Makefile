RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
PLAIN = \033[0m

all: up

down:
	docker compose -f ./srcs/docker-compose.yml down

up:
	@echo "$(GREEN)Building and Starting Containers$(PLAIN)"
	docker compose -f ./srcs/docker-compose.yml up --build

start:
	@echo "$(GREEN)Starting Stopped Containers$(PLAIN)"
	docker compose -f ./srcs/docker-compose.yml start

stop:
	@echo "$(RED)Stopping Containers$(PLAIN)"
	docker compose -f ./srcs/docker-compose.yml stop

prune:
	@echo "$(RED)Removing all unused stuff$(PLAIN)"
	docker system prune -f

clean: down prune
	@echo "$(RED)Removing volumes$(PLAIN)"
	@docker volume rm srcs_mariadb_data srcs_wordpress_files
	@rm -rf /home/bzawko/data/mysql/* /home/bzawko/data/wordpress/*

.PHONY: all down up clean
