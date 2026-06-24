local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.asciidoc = {
    install_info = {
        url = "https://github.com/cathaysia/tree-sitter-asciidoc",
        branch = "master",
        location = "tree-sitter-asciidoc",
        files = { "src/parser.c", "src/scanner.c" },
        queries = "queries/asciidoc/",
        requires = { "asciidoc_inline" }
    }
}

parser_config.asciidoc_inline = {
    install_info = {
        url = "https://github.com/cathaysia/tree-sitter-asciidoc",
        branch = "master",
        location = "tree-sitter-asciidoc_inline",
        files = { "src/parser.c", "src/scanner.c" },
        queries = "queries/asciidoc_inline/"
    }
}
