return {
    settings = {
        python = {
            builtin = {
                installExtraArgs = { 'flake8', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylint', 'yapf' },
            },
            plugins = {
                jedi_completion = { enabled = false },
                rope_completion = { enabled = false },
                flake8 = { enabled = false },
                pyflakes = { enabled = false },
                pycodestyle = {
                    ignore = { 'E226', 'E266', 'E302', 'E303', 'E304', 'E305', 'E402', 'C0103', 'W0104', 'W0621', 'W391',
                        'W503', 'W504' },
                    maxLineLength = 150,
                },
            },
        },
    },
}
