runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'doorboy#brackts'
  before
    new
  end

  after
    close!
  end

  context 'when no characters in the current line'
    " ()
    context 'and putting (#'
      it 'should be (#)'
        call spec_helper#insert_chars('(#')
        Expect getline(1) == '(#)'
      end
    end

    " {}
    context 'and putting {#'
      it 'should be {#}'
        call spec_helper#insert_chars('{#')
        Expect getline(1) == '{#}'
      end
    end

    " []
    context 'and putting [#'
      it 'should be [#]'
        call spec_helper#insert_chars('[#')
        Expect getline(1) == '[#]'
      end
    end
  end

  context 'when cursor is left of opening bracket'
    before
      call spec_helper#put_with_cursor('|()')
    end

    context 'and putting (SKIP'
      it 'should be (SKIP)'
        call spec_helper#insert_chars('(SKIP')
        Expect getline(1) == '(SKIP)'
      end
    end
  end

  context 'when cursor is between brackets'
    before
      call spec_helper#put_with_cursor('(|)')
    end

    context 'and pressing backspace'
      it 'should delete brackets'
        call spec_helper#insert_bs()
        Expect getline(1) == ''
      end
    end

    context 'and pressing close bracket'
      it 'should skip out of brackets'
        call spec_helper#insert_chars(')')
        Expect getline(1) == '()'
      end
    end
  end
end
