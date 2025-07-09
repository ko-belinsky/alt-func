.PHONY: install

HOME_DIR := $(HOME)
BASHRC := $(HOME_DIR)/.bashrc
BASH_FUNC_SRC := .bash_func
BASH_FUNC_DEST := $(HOME_DIR)/.bash_func

install: copy_bash_func update_bashrc

copy_bash_func:
	@echo "Копирование .bash_func в домашнюю директорию..."
	@cp -v $(BASH_FUNC_SRC) $(BASH_FUNC_DEST)

update_bashrc:
	@if ! grep -q "source ~/.bash_func" $(BASHRC) || ! grep -q "alias rsv='rs -v'" $(BASHRC); then \
		echo "Добавление настроек в .bashrc..."; \
		echo "" >> $(BASHRC); \
		echo "# Подключение функций поиска и обновления пакетов rs, isv, dist-upgrade" >> $(BASHRC); \
		echo "if [ -f ~/.bash_func ]; then" >> $(BASHRC); \
		echo "    source ~/.bash_func" >> $(BASHRC); \
		echo "fi" >> $(BASHRC); \
		echo "" >> $(BASHRC); \
		echo "alias rsv='rs -v'" >> $(BASHRC); \
		echo "Настройки успешно добавлены в .bashrc"; \
	else \
		echo "Настройки уже присутствуют в .bashrc, пропускаем..."; \
	fi

uninstall:
	@echo "Удаление .bash_func из домашней директории..."
	@rm -vf $(BASH_FUNC_DEST)
	@echo "Удаление настроек из .bashrc..."
	@sed -i '/# Подключение функций поиска и обновления пакетов rs, isv, dist-upgrade/,/alias rsv='"'"'rs -v'"'"'/d' $(BASHRC)
