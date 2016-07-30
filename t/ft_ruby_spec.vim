runtime! plugin/doorboy.vim

source spec_helper.vim

set filetype=ruby

describe 'ftplugin/ruby'
  after
    normal ggdG
  end

  context 'when no characters in the current line'
    context 'and putting |'
      it 'should put | twice'
        call spec_helper#insert_chars('|ruby')
        Expect getline(1) == '|ruby|'
      end
    end

    context 'and putting /'
      it 'should put / twice'
        call spec_helper#insert_chars('/ruby')
        Expect getline(1) == '/ruby/'
      end
    end
  end

  context 'when in regular expression'
    context 'and in front of NOT /'
      before
        call spec_helper#put_with_cursor('/(|)/')
      end
      context 'and putting |'
        it 'should put | once'
          call spec_helper#insert_chars('|ruby')
          Expect getline(1) == '/(|ruby)/'
        end
      end
    end
    context 'and in front of /'
      before
        call spec_helper#put_with_cursor('/ruby|/')
      end
      context 'and putting |'
        it 'should skip'
          call spec_helper#insert_chars('/ =~')
          Expect getline(1) == '/ruby/ =~'
        end
      end
    end
  end

  context 'when in string literals'
    context 'and srrounded by "'
      before
        call spec_helper#put_with_cursor('"|"')
      end
      context 'and putting #var'
        it 'should put #{}<LEFT>'
          call spec_helper#insert_chars('#var')
          Expect getline(1) == '"#{var}"'
        end
      end
    end
    context "and srrounded by '"
      before
        call spec_helper#put_with_cursor("'|'")
      end
      context 'and putting #'
        it 'should just put #'
          call spec_helper#insert_chars('#')
          Expect getline(1) == "'#'"
        end
      end
    end
  end
end
