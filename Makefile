DOT_FILES = .bashrc .profile .gitconfig .tmux.conf .vimrc .config/nvim/init.vim
DOT_DIR = bash git tmux vim

.PHONY: help
help:
	@echo "This make file has options avaliable to make sure the dotfiles are configured" \
          "\nin their ideal location.\n" \
          "\nRun make dotfiles to backup your currently existing files into a .old directory" \
	  "\nwithin this git and link the dotfiles for all available programs.\n" \
          "\nRun make clean to remove the dotfiles linked from this git and restoreyour previous dotfiles."

.PHONY: backup_folder
backup_folder:
	@mkdir -p $(CURDIR)/.old;
	@mkdir -p $(CURDIR)/.old/.config/nvim/init.vim;
	@echo "Backup folder created or already exists.\n"

.PHONY: backup
backup: backup_folder
	@for FILE in $(DOT_FILES) ; do \
          echo $$FILE; \
          [ -f $(shell echo ~)/$$FILE ] && ( \
            [ ! -f $(CURDIR)/.old/$$FILE ] && ( \
              cp -n $(shell echo ~)/$$FILE $(CURDIR)/.old/$$FILE; \
              echo "Backed up.\n" \
            ) || ( \
              echo "Backup already exists.\n" \
            ); \
            rm $(shell echo ~)/$$FILE; \
            echo "File deleted.\n" \
          ) || \
            echo "Doesn't exists, thus ignored.\n"; \
	done

.PHONY: dotfiles
dotfiles: backup
	@for DIR in $(DOT_DIR) ; do \
          echo $$DIR; \
          stow -t ~ -R $$DIR; \
	done

.PHONY: clean
clean:
	@for FILE in $(DOT_FILES) ; do \
          echo $$FILE; \
          [ -f $(CURDIR)/.old/$$FILE ] && ( \
            [ -L $(shell echo ~)/$$FILE ] && ( \
              rm $(shell echo ~)/$$FILE; \
              echo "Symbolic link deleted" \
            ) || \
              echo "File is not symbolic link, assumed it's not from this git.\n"; \
            [ ! -f $(shell echo ~)/$$FILE ] && ( \
              mv $(CURDIR)/.old/$$FILE $(shell echo ~)/$$FILE; \
              echo "File restored from backup.\n" \
            ) \
          ) || \
            echo "Backup doesn't exists, thus ignored.\n"; \
	done
