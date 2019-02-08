DOT_FILES = /.bashrc /.profile /.gitconfig /.tmux.conf /.vimrc
AUX_FILES = /.config/nvim/init.vim
BK_PATH := $(subst $(DOT_FILES), ~, $(CURDIR)/.old)
.PHONY: help
help:
	@echo "This make file has options avaliable to make sure the dotfiles are configured" \
          "\nin their ideal location.\n" \
          "\nRun make to backup your currently existing files into a .old directory" \
	  "\nwithin this git and link the dotfiles for all available programs"

.PHONY: backup_folder
backup_folder:
	@echo $(DOT_FILES)
	@echo $(BK_PATH)
	@mkdir -p $(CURDIR)/.old

.PHONY: backup
backup: backup_folder
	@for FILE in $(DOT_FILES) ; do \
          echo $$FILE; \
          echo $(subst $$FILE, ~, $(CURDIR)/.old); \
          [ -f ~$$FILE ] && ( \
            [ ! -f $(BK_PATH)$(subst $$FILE, ~, $(CURDIR)/.old) ] && ( \
              cp -n $$FILE $(subst $$FILE, ~, $(CURDIR)/.old); \
              echo "Backed up.\n" \
            ) || \
              echo "Backup already exists.\n" \
          ) || \
            echo "Doesn't exists, thus ignored.\n"; \
	done
