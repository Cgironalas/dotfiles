DOT_FILES = .bashrc .profile .gitconfig .tmux.conf .vimrc
AUX_FILES = .config/nvim/init.vim

.PHONY: help
help:
	@echo "This make file has options avaliable to make sure the dotfiles are configured" \
          "\nin their ideal location.\n" \
          "\nRun make to backup your currently existing files into a .old directory" \
	  "\nwithin this git and link the dotfiles for all available programs"

.PHONY: backup_folder
backup_folder:
	@mkdir -p $(CURDIR)/.old

.PHONY: backup
backup: backup_folder
	@for FILE in $(DOT_FILES) ; do \
          echo $$FILE; \
          $(eval OLD_FILE = $(shell echo ~)/$(shell echo $(FILE))) \
          $(eval BK_FILE = $(CURDIR)/.old/$(FILE)) \
          echo $(OLD_FILE); \
          echo $(BK_FILE); \
          [ -f $(shell echo ~)/$$FILE ] && ( \
            [ ! -f $(CURDIR)/.old/$$FILE ] && ( \
              cp -n $(shell echo ~)/$$FILE $(CURDIR)/.old/$$FILE; \
              echo "Backed up.\n" \
            ) || \
              echo "Backup already exists.\n" \
          ) || \
            echo "Doesn't exists, thus ignored.\n"; \
	done
