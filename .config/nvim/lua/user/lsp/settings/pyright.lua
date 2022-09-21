return {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportGeneralTypeIssues = "none",
                    reportOptionalMemberAccess = "none",
                    reportOptionalSubscript = "none",
                    reportPrivateImportUsage = "none",
                },
                autoImportCompletions = true,
            },
            linting = {pylintEnabled = true}
        },
    },
}
