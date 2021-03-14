{ pkgs, ... }: {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins; [
        incsearch-vim
      	yankring
        vim-airline
        elm-vim
        i3config-vim
        fzf-vim
        neocomplete
	      vim-nix
        nerdtree
	{ plugin = vim-startify;
	  config = "let g:startify_change_to_vcs_root = 0";
	}
      ];
      extraConfig = ''
        let mapleader = ","
        let NERDTreeShowHidden=1
        
        autocmd FocusGained * silent! checktime

        set ignorecase
        set noswapfile
        set autoread
        set modifiable
        set number
        set incsearch
        set filetype=i3config
        set softtabstop=4
        set shiftwidth=4
        
        :au CursorHold * :checktime
        :au FocusLost * :wa

        nmap <C-n> :NERDTreeToggle<CR>
        map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

        colorscheme pablo

        filetype plugin on
        filetype indent on
      '';
    };
  }
