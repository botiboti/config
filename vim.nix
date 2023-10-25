{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      incsearch-vim
      nvim-treesitter
      yankring
      vim-airline
      elm-vim
      i3config-vim
      fzf-vim
      neocomplete
      vim-autoformat
      vim-nix
      tokyonight-nvim
      nerdtree
      {
        plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }
    ];
    extraConfig = ''
      let mapleader = ","
      let maplocalleader = "*"
      let NERDTreeShowHidden=1
      let g:loaded_python_provider = 0

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
      set background=dark

      :au CursorHold * :checktime
      :au FocusLost * :Autoformat
      :au FocusLost * :wa

      nmap <C-n> :NERDTreeToggle<CR>
      map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

      colorscheme tokyonight-night

      filetype plugin on
      filetype indent on
    '';
  };
}
