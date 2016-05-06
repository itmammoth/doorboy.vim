runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'ftplugin/vim'
  before
    new
    filetype plugin on
    set filetype=vim
  end

  after
    close!
  end

  context 'when putting "'
    context 'and cursor is beginning of line'
      it 'should put a "'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"'
      end
    end

    context 'and there are some words left from cursor'
      before
        call spec_helper#put_with_cursor('words |')
      end
      it 'should put ""'
        call spec_helper#append_chars('"')
        Expect getline(1) == 'words ""'
      end
    end
  end
end
