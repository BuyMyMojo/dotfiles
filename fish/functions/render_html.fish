function render_html --description 'gets content of provided file and renders as if it  were html';
    cat $argv[1] | lynx --stdin;
end