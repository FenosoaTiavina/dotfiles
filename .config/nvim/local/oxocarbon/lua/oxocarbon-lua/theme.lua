local extend_with_attributes = function(orig, attrs)
    if not attrs then
        return orig
    end

    for _, attr in ipairs(attrs) do
        orig[attr] = 1
    end
    return orig
end

local conditional_bg = function(arg)
    if vim.g.oxocarbon_lua_transparent then
        return 'none'
    else
        return arg
    end
end

local Theme = {}

Theme.set_terminal_colors = function(colors)
    if vim.g.oxocarbon_lua_keep_terminal then
        return
    end

    vim.api.nvim_set_var('terminal_color_background', colors[1])
    vim.api.nvim_set_var('terminal_color_foreground', colors[5])

    for x = 0, 15 do
        vim.api.nvim_set_var('terminal_color_' .. x, colors[x + 1])
    end
end

Theme.set_general_highlights = function(colors)
    local highlight = function(name, fg, bg, attrs)
        local fg_color = colors[fg]
        local bg_color = colors[bg]

        vim.api.nvim_set_hl(
            0,
            name,
            extend_with_attributes(
                {
                    fg = fg_color,
                    bg = bg_color,
                },
                attrs
            )
        )
    end
    local none = 18

    local conditional_italic = vim.g.oxocarbon_lua_disable_italic and nil or { 'italic' }


    -- editor
    highlight('ColorColumn', none, 2)
    highlight('Cursor', 1, 5)
    highlight('CursorLine', none, 2, { 'underline' })
    highlight('CursorColumn', none, 2)
    highlight('CursorLineNr', 14, conditional_bg(none))
    highlight('QuickFixLine', none, 2)
    highlight('Error', 5, 11)
    highlight('LineNr', 5, conditional_bg(1))
    highlight('NonText', 3, conditional_bg(none))
    highlight('Normal', 5, conditional_bg(1))
    highlight('Pmenu', 5, 2)
    highlight('PmenuSbar', 5, 2)
    highlight('PmenuSel', 9, 3)
    highlight('PmenuThumb', 9, 3)
    highlight('SpecialKey', 4, none)
    highlight('Visual', 11, 17)
    highlight('VisualNOS', none, 3)
    highlight('TooLong', none, 3)
    highlight('Debug', 14, none)
    highlight('Macro', 8, none)
    highlight('MatchParen', none, 3, { 'underline' })
    highlight('Bold', none, none, { 'bold' })
    highlight('Italic', none, none, { 'italic' })
    highlight('Underlined', none, none, { 'underline' })

    -- diagnostics
    highlight('DiagnosticWarn', 9, none)
    highlight('DiagnosticError', 11, none)
    highlight('DiagnosticInfo', 12, none)
    highlight('DiagnosticHint', 15, none)
    highlight('DiagnosticUnderlineWarn', 9, none, { 'undercurl' })
    highlight('DiagnosticUnderlineError', 11, none, { 'undercurl' })
    highlight('DiagnosticUnderlineInfo', 12, none, { 'undercurl' })
    highlight('DiagnosticUnderlineHint', 15, none, { 'undercurl' })

    -- lsp
    highlight('LspReferenceText', none, 4)
    highlight('LspReferenceread', none, 4)
    highlight('LspReferenceWrite', none, 4)
    highlight('LspSignatureActiveParameter', 9, none)

    -- gutter
    highlight('Folded', 4, conditional_bg(2))
    highlight('FoldColumn', 4, conditional_bg(1))
    highlight('SignColumn', 2, conditional_bg(1))

    -- navigation
    highlight('Directory', 9, none)

    -- prompts
    highlight('EndOfBuffer', 2, none)
    highlight('ErrorMsg', 5, 12)
    highlight('ModeMsg', 5, none)
    highlight('MoreMsg', 9, none)
    highlight('Question', 5, none)
    highlight('Substitute', 17, 14)
    highlight('WarningMsg', 1, 14)
    highlight('WildMenu', 9, 2)

    -- search
    highlight('IncSearch', 7, 11)
    highlight('Search', 2, 9)
    highlight('CurSearch', 2, 14)

    -- tabs
    highlight('TabLine', 5, 2)
    highlight('TabLineFill', 5, 2)
    highlight('TabLineSel', 9, 4)

    -- window
    highlight('Title', 5, none)
    highlight('VertSplit', 2, 1)

    -- regular syntax
    highlight('Boolean', 10, none)
    highlight('Character', 15, none)
    highlight('Comment', 17, none)
    highlight('Conceal', none, none)
    highlight('Conditional', 10, none)
    highlight('Constant', 5, none)
    highlight('Decorator', 13, none)
    highlight('Define', 10, none)
    highlight('Delimeter', 7, none)
    highlight('Exception', 10, none)
    highlight('Float', 16, none)
    highlight('Function', 9, none)
    highlight('Identifier', 5, none)
    highlight('Include', 10, none)
    highlight('Keyword', 10, none)
    highlight('Label', 10, none)
    highlight('Number', 16, none)
    highlight('Operator', 10, none)
    highlight('PreProc', 10, none)
    highlight('Repeat', 10, none)
    highlight('Special', 5, none)
    highlight('SpecialChar', 5, none)
    highlight('SpecialComment', 9, none)
    highlight('Statement', 10, none)
    highlight('StorageClass', 10, none)
    highlight('String', 15, none)
    highlight('Structure', 10, none)
    highlight('Tag', 5, none)
    highlight('Todo', 14, none)
    highlight('Type', 10, none)
    highlight('Typedef', 10, none)

    -- treesitter
    highlight('@annotation', 13, none)
    highlight('@attribute', 16, none)
    highlight('@boolean', 10, none)
    highlight('@character', 15, none)
    highlight('@constructor', 10, none)
    highlight('@conditional', 10, none)
    highlight('@constant', 15, none)
    highlight('@const.builtin', 8, none)
    highlight('@const.macro', 8, none)
    highlight('@error', 12, none)
    highlight('@exception', 16, none)
    highlight('@field', 5, none)
    highlight('@float', 16, none)
    highlight('@func.builtin', 13, none)
    highlight('@func.macro', 8, none)
    highlight('@include', 10, none)
    highlight('@keyword', 10, none)
    highlight('@keyword.function', 9, none)
    highlight('@keyword.operator', 9, none)
    highlight('@label', 16, none)
    highlight('@method', 8, none)
    highlight('@namespace', 5, none)
    highlight('@number', 16, none)
    highlight('@operator', 10, none)
    highlight('@parameter', 5, none)
    highlight('@parameter.reference', 5, none)
    highlight('@property', 11, none)
    highlight('@punct.delimiter', 9, none)
    highlight('@punct.bracket', 9, none)
    highlight('@punct.special', 9, none)
    highlight('@repeat', 10, none)
    highlight('@string', 15, none)
    highlight('@string.regex', 8, none)
    highlight('@string.escape', 16, none)
    highlight('@tag', 5, none)
    highlight('@tag.delimiter', 16, none)
    highlight('@text', 5, none)
    highlight('@title', 11, none)
    highlight('@literal', 5, none)
    highlight('@type', 10, none)
    highlight('@type.builtin', 5, none)
    highlight('@variable', 5, none)
    highlight('@variable.builtin', 5, none)
    highlight('@strong', none, none, { 'bold' })
    highlight('@comment', 7, 17, conditional_italic)
    highlight('@function', 13, none, { 'bold' })
    highlight('@symbol', 16, none, { 'bold' })
    highlight('@emphasis', 11, none, { 'bold' })
    highlight('@underline', 11, none, { 'underline' })
    highlight('@strike', 11, none, { 'strikethrough' })
    highlight('@uri', 15, none, { 'underline' })
    highlight('@current.scope', none, none, { 'bold' })
    highlight('TreesitterContext', none, 2)

    -- neovim
    highlight('NvimInternalError', 1, 9)
    highlight('NormalFloat', 6, 17)
    highlight('FloatBorder', 6, none)
    highlight('NormalNC', 6, 1)
    highlight('TermCursor', 1, 5)
    highlight('TermCursorNC', 1, 5)

    -- statusline/winbar
    highlight('StatusLine', 7, none)
    highlight('StatusLineNC', 4, none)
    highlight('StatusReplace', 1, 9)
    highlight('StatusInsert', 1, 13)
    highlight('StatusVisual', 1, 15)
    highlight('StatusTerminal', 1, 12)
    highlight('StatusLineDiagnosticWarn', 15, 1, { 'bold' })
    highlight('StatusLineDiagnosticError', 9, 1, { 'bold' })
    highlight('WinBar', 20, 1, { 'bold' })
    highlight('StatusPosition', 20, 1, { 'bold' })
    highlight('StatusNormal', 20, 1, { 'underline' })
    highlight('StatusCommand', 20, 1, { 'underline' })

    -- telescope
    if vim.g.oxocarbon_lua_alternative_telescope then
        highlight('TelescopeBorder', 6, none)
        highlight('TelescopePromptCounter', 6, 9)
        highlight('TelescopePromptNormal', 6, none)
        highlight('TelescopePromptPrefix', 8, none)

        highlight('TelescopeNormal', 5, none)

        highlight('TelescopePreviewTitle', 19, none)
        highlight('TelescopePromptTitle', 19, none)
        highlight('TelescopeResultsTitle', 19, none)

        highlight('TelescopeSelection', none, 3)
    else
        highlight('TelescopeBorder', 17, 17)
        highlight('TelescopePromptBorder', 3, 3)
        highlight('TelescopePromptNormal', 6, 3)
        highlight('TelescopePromptPrefix', 9, 3)
        highlight('TelescopeNormal', none, 17)
        highlight('TelescopePreviewTitle', 3, 12)
        highlight('TelescopePromptTitle', 3, 9)
        highlight('TelescopeResultsTitle', 17, 17)
        highlight('TelescopeSelection', none, 3)
        highlight('TelescopePreviewLine', none, 2)
    end

    -- cmp
    highlight('CmpItemAbbrMatchFuzzy', 5, none)
    highlight('CmpItemKindInterface', 12, none)
    highlight('CmpItemKindText', 9, none)
    highlight('CmpItemKindVariable', 14, none)
    highlight('CmpItemKindProperty', 11, none)
    highlight('CmpItemKindKeyword', 10, none)
    highlight('CmpItemKindUnit', 15, none)
    highlight('CmpItemKindFunction', 13, none)
    highlight('CmpItemKindMethod', 8, none)
    highlight('CmpItemAbbrMatch', 6, none, { 'bold' })
    highlight('CmpItemAbbr', 20, none, { 'bold' })

    -- nvimtree
    highlight('NvimTreeImageFile', 13, none)
    highlight('NvimTreeFolderIcon', 13, none)
    highlight('NvimTreeWinSeperator', 1, 1)
    highlight('NvimTreeFolderName', 10, none)
    highlight('NvimTreeIndentMarker', 3, none)
    highlight('NvimTreeEmptyFolderName', 16, none)
    highlight('NvimTreeOpenedFolderName', 16, none)
    highlight('NvimTreeNormal', 5, 17)

    -- neogit
    highlight('NeogitBranch', 11, none)
    highlight('NeogitRemote', 10, none)
    highlight('NeogitDiffAddHighlight', 14, 3)
    highlight('NeogitDiffDeleteHighlight', 10, 3)
    highlight('NeogitDiffContextHighlight', 5, 2)
    highlight('NeogitHunkHeader', 5, 3)
    highlight('NeogitHunkHeaderHighlight', 5, 4)

    -- gitsigns
    highlight('GitSignsAdd', 9, none)
    highlight('GitSignsChange', 10, none)
    highlight('GitSignsDelete', 15, none)

    -- parinfer
    highlight('Trailhighlight', 4, none)


    -- blink
    highlight('BlinkCmpDoc', 7, none, {})
    highlight('BlinkCmpDocBorder', 7, none, {})
    highlight('BlinkCmpDocCursorLine', 7, none, {})
    highlight('BlinkCmpDocSeparator', 7, none, {})


    highlight('BlinkCmpMenu', 7, none, {})
    highlight('BlinkCmpMenuBorder', 7, none, {})
    highlight('BlinkCmpMenuSelection', none, none, { 'underline', 'bold' })

    highlight('BlinkCmpSource', 13, none, {})
    highlight('BlinkCmpGhostText', 4, none, {})

    highlight('BlinkCmpSignatureHelpBorder', 17, none, {})
    highlight('BlinkCmpSignatureHelp', 17, none, {})


    highlight('BlinkCmpKind', 11, none, {})
    -- highlight('BlinkCmpKindClass', 17, none, {})
    -- highlight('BlinkCmpKindEnum', 17, none, {})
    -- highlight('BlinkCmpKindFile', 17, none, {})
    -- highlight('BlinkCmpKindText', 17, none, {})
    -- highlight('BlinkCmpKindUnit', 17, none, {})
    -- highlight('BlinkCmpKindColor', 17, none, {})
    -- highlight('BlinkCmpKindEvent', 17, none, {})
    -- highlight('BlinkCmpKindField', 17, none, {})
    -- highlight('BlinkCmpKindValue', 17, none, {})
    -- highlight('BlinkCmpKindFolder', 17, none, {})
    -- highlight('BlinkCmpKindMethod', 17, none, {})
    -- highlight('BlinkCmpKindModule', 17, none, {})
    -- highlight('BlinkCmpKindStruct', 17, none, {})
    -- highlight('BlinkCmpKindKeyword', 17, none, {})
    -- highlight('BlinkCmpKindSnippet', 17, none, {})
    -- highlight('BlinkCmpKindConstant', 17, none, {})
    -- highlight('BlinkCmpKindFunction', 17, none, {})
    -- highlight('BlinkCmpKindOperator', 17, none, {})
    -- highlight('BlinkCmpKindProperty', 17, none, {})
    -- highlight('BlinkCmpKindVariable', 17, none, {})
    -- highlight('BlinkCmpKindInterface', 17, none, {})
    -- highlight('BlinkCmpKindReference', 17, none, {})
    -- highlight('BlinkCmpKindEnumMember', 17, none, {})
    -- highlight('BlinkCmpKindConstructor', 17, none, {})
    -- highlight('BlinkCmpKindTypeParameter', 17, none, {})

    highlight('BlinkCmpLabelDetail', 15, none, {})
    -- highlight('BlinkCmpLabelDeprecated', 17, none, {})


    -- highlight('BlinkCmpScrollBarThumb', none, 17, {})
    -- highlight('BlinkCmpScrollBarGutter', 17, none, {})
    -- highlight('BlinkCmpLabelDescription', 17, none, {})
    -- highlight('BlinkCmpCursorLineMenuHack', 17, none, {})
    -- highlight('BlinkCmpSignatureHelpActiveParameter', 17, none, {})

    -- mini-icons
    highlight('MiniIconsRed', 11, none, {})
    highlight('MiniIconsBlue', 12, none, {})
    highlight('MiniIconsCyan', 16, none, {})
    highlight('MiniIconsGrey', 4, none, {})
    highlight('MiniIconsAzure', 10, none, {})
    highlight('MiniIconsGreen', 14, none, {})
    highlight('MiniIconsOrange', 13, none, {})
    highlight('MiniIconsPurple', 15, none, {})
    highlight('MiniIconsYellow', 16, none, {})

    -- highlight('MiniNotifyTitle', 16, none, {})
    highlight('MiniNotifyBorder', 17, none, {})
    highlight('MiniNotifyNormal', 16, none, {})
    highlight('MiniNotifyLspProgress', 16, none, {})




    --[[ highlight('SnacksInputIcon', 17, none, {})
  highlight('SnacksPickerCmd', 17, none, {})
  highlight('SnacksPickerCol', 17, none, {})
  highlight('SnacksPickerDir', 17, none, {})
  highlight('SnacksPickerIdx', 17, none, {})
  highlight('SnacksPickerRow', 17, none, {})
  highlight('SnacksInputTitle', 17, none, {})
  highlight('SnacksPickerBold', 17, none, {})
  highlight('SnacksPickerCode', 17, none, {})
  highlight('SnacksPickerDesc', 17, none, {})
  highlight('SnacksPickerFile', 17, none, {})
  highlight('SnacksPickerIcon', 17, none, {})
  highlight('SnacksPickerLink', 17, none, {})
  highlight('SnacksPickerTime', 17, none, {})
  highlight('SnacksPickerTree', 17, none, {})
  highlight('SnacksInputBorder', 17, none, {})
  highlight('SnacksInputNormal', 17, none, {})
  highlight('SnacksInputPrompt', 17, none, {})
  highlight('SnacksPickerBufNr', 17, none, {})
  highlight('SnacksPickerDelim', 17, none, {})
  highlight('SnacksPickerLabel', 17, none, {})
  highlight('SnacksPickerMatch', 17, none, {})
  highlight('SnacksPickerDimmed', 17, none, {})
  highlight('SnacksPickerItalic', 17, none, {})
  highlight('SnacksPickerPrompt', 17, none, {})
  highlight('SnacksPickerSearch', 17, none, {})
  highlight('SnacksPickerToggle', 17, none, {})
  highlight('SnacksPickerTotals', 17, none, {})
  highlight('SnacksPickerAuEvent', 17, none, {})
  highlight('SnacksPickerAuGroup', 17, none, {})
  highlight('SnacksPickerComment', 17, none, {})
  highlight('SnacksPickerGitDate', 17, none, {})
  highlight('SnacksPickerGitType', 17, none, {})
  highlight('SnacksPickerIconKey', 17, none, {})
  highlight('SnacksPickerManPage', 17, none, {})
  highlight('SnacksPickerPickWin', 17, none, {})
  highlight('SnacksPickerSpecial', 17, none, {})
  highlight('SnacksPickerSpinner', 17, none, {})
  highlight('SnacksPickerBufFlags', 17, none, {})
  highlight('SnacksPickerGitIssue', 17, none, {})
  highlight('SnacksPickerGitScope', 17, none, {})
  highlight('SnacksPickerIconEnum', 17, none, {})
  highlight('SnacksPickerIconFile', 17, none, {})
  highlight('SnacksPickerIconName', 17, none, {})
  highlight('SnacksPickerIconNull', 17, none, {})
  highlight('SnacksPickerRegister', 17, none, {})
  highlight('SnacksPickerSelected', 17, none, {})
  highlight('SnacksPickerAuPattern', 17, none, {})
  highlight('SnacksPickerDirectory', 17, none, {})
  highlight('SnacksPickerGitBranch', 17, none, {})
  highlight('SnacksPickerGitCommit', 17, none, {})
  highlight('SnacksPickerGitStatus', 17, none, {})
  highlight('SnacksPickerIconArray', 17, none, {})
  highlight('SnacksPickerIconClass', 17, none, {})
  highlight('SnacksPickerIconEvent', 17, none, {})
  highlight('SnacksPickerIconField', 17, none, {})
  highlight('SnacksPickerKeymapLhs', 17, none, {})
  highlight('SnacksPickerKeymapRhs', 17, none, {})
  highlight('SnacksPickerUndoAdded', 17, none, {})
  highlight('SnacksPickerUndoSaved', 17, none, {})
  highlight('SnacksPickerCmdBuiltin', 17, none, {})
  highlight('SnacksPickerIconMethod', 17, none, {})
  highlight('SnacksPickerIconModule', 17, none, {})
  highlight('SnacksPickerIconNumber', 17, none, {})
  highlight('SnacksPickerIconObject', 17, none, {})
  highlight('SnacksPickerIconSource', 17, none, {})
  highlight('SnacksPickerIconString', 17, none, {})
  highlight('SnacksPickerIconStruct', 17, none, {})
  highlight('SnacksPickerKeymapMode', 17, none, {})
  highlight('SnacksPickerLinkBroken', 17, none, {})
  highlight('SnacksPickerLspEnabled', 17, none, {})
  highlight('SnacksPickerManSection', 17, none, {})
  highlight('SnacksPickerPathHidden', 17, none, {})
  highlight('SnacksPickerUnselected', 17, none, {})
  highlight('SnacksPickerGitBreaking', 17, none, {})
  highlight('SnacksPickerGitDetached', 17, none, {})
  highlight('SnacksPickerIconBoolean', 17, none, {})
  highlight('SnacksPickerIconPackage', 17, none, {})
  highlight('SnacksPickerInputSearch', 17, none, {})
  highlight('SnacksPickerLspAttached', 17, none, {})
  highlight('SnacksPickerLspDisabled', 17, none, {})
  highlight('SnacksPickerPathIgnored', 17, none, {})
  highlight('SnacksPickerToggleRegex', 17, none, {})
  highlight('SnacksPickerUndoCurrent', 17, none, {})
  highlight('SnacksPickerUndoRemoved', 17, none, {})
  highlight('SnacksPickerIconCategory', 17, none, {})
  highlight('SnacksPickerIconConstant', 17, none, {})
  highlight('SnacksPickerIconFunction', 17, none, {})
  highlight('SnacksPickerIconOperator', 17, none, {})
  highlight('SnacksPickerIconProperty', 17, none, {})
  highlight('SnacksPickerIconVariable', 17, none, {})
  highlight('SnacksPickerKeymapNowait', 17, none, {})
  highlight('SnacksPickerToggleFollow', 17, none, {})
  highlight('SnacksPickerToggleHidden', 17, none, {})
  highlight('SnacksPickerIconInterface', 17, none, {})
  highlight('SnacksPickerIconNamespace', 17, none, {})
  highlight('SnacksPickerToggleIgnored', 17, none, {})
  highlight('SnacksPickerDiagnosticCode', 17, none, {})
  highlight('SnacksPickerGitStatusAdded', 17, none, {})
  highlight('SnacksPickerIconEnumMember', 17, none, {})
  highlight('SnacksPickerLspAttachedBuf', 17, none, {})
  highlight('SnacksPickerLspUnavailable', 17, none, {})
  highlight('SnacksPickerPickWinCurrent', 17, none, {})
  highlight('SnacksPickerToggleModified', 17, none, {})
  highlight('SnacksPickerGitStatusCopied', 17, none, {})
  highlight('SnacksPickerGitStatusStaged', 17, none, {})
  highlight('SnacksPickerIconConstructor', 17, none, {})
  highlight('SnacksPickerDiagnosticSource', 17, none, {})
  highlight('SnacksPickerGitBranchCurrent', 17, none, {})
  highlight('SnacksPickerGitStatusDeleted', 17, none, {})
  highlight('SnacksPickerGitStatusIgnored', 17, none, {})
  highlight('SnacksPickerGitStatusRenamed', 17, none, {})
  highlight('SnacksPickerGitStatusModified', 17, none, {})
  highlight('SnacksPickerGitStatusUnmerged', 17, none, {})
  highlight('SnacksPickerIconTypeParameter', 17, none, {})
  highlight('SnacksPickerGitStatusUntracked', 17, none, {}) ]]

    -- statusline
    highlight('SlFgWhite', 7, none, {})
    highlight('SlFgGrey', 4, none, {})
    highlight('SlFgLightGrey', 19, none, {})
    highlight('SlFgDarkGrey', 1, none, {})
    highlight('SlFgRed', 11, none, {})
    highlight('SlFgBlue', 12, none, {})
    highlight('SlFgCyan', 16, none, {})
    highlight('SlFgAzure', 10, none, {})
    highlight('SlFgGreen', 14, none, {})
    highlight('SlFgOrange', 13, none, {})
    highlight('SlFgPurple', 15, none, {})
    highlight('SlFgYellow', 16, none, {})


    highlight('SlBgWhite', none, 7, {})
    highlight('SlBgGrey', none, 4, {})
    highlight('SlBgLightGrey', none, 19, {})
    highlight('SlBgDarkGrey', none, 1, {})
    highlight('SlBgRed', none, 11, {})
    highlight('SlBgBlue', none, 12, {})
    highlight('SlBgCyan', none, 16, {})
    highlight('SlBgAzure', none, 10, {})
    highlight('SlBgGreen', none, 14, {})
    highlight('SlBgOrange', none, 13, {})
    highlight('SlBgPurple', none, 15, {})
    highlight('SlBgYellow', none, 16, {})


    -- highlight('GitSignsAdd', none, none, {})
    -- highlight('GitSignsAddLn', none, none, {})
    -- highlight('GitSignsAddNr', none, none, {})
    -- highlight('GitSignsAddCul', none, none, {})
    -- highlight('GitSignsChange', none, none, {})
    -- highlight('GitSignsDelete', none, none, {})
    -- highlight('GitSignsChangeLn', none, none, {})
    -- highlight('GitSignsChangeNr', none, none, {})
    -- highlight('GitSignsDeleteNr', none, none, {})
    -- highlight('GitSignsVirtLnum', none, none, {})
    -- highlight('GitSignsAddInline', none, none, {})
    -- highlight('GitSignsChangeCul', none, none, {})
    -- highlight('GitSignsDeleteCul', none, none, {})
    -- highlight('GitSignsStagedAdd', none, none, {})
    -- highlight('GitSignsTopdelete', none, none, {})
    -- highlight('GitSignsUntracked', none, none, {})
    -- highlight('GitSignsAddPreview', none, none, {})
    -- highlight('GitSignsAddLnInline', none, none, {})
    -- highlight('GitSignsStagedAddLn', none, none, {})
    -- highlight('GitSignsStagedAddNr', none, none, {})
    -- highlight('GitSignsTopdeleteLn', none, none, {})
    -- highlight('GitSignsTopdeleteNr', none, none, {})
    -- highlight('GitSignsUntrackedLn', none, none, {})
    -- highlight('GitSignsUntrackedNr', none, none, {})
    -- highlight('GitSignsChangeInline', none, none, {})
    -- highlight('GitSignsChangedelete', none, none, {})
    -- highlight('GitSignsDeleteInline', none, none, {})
    -- highlight('GitSignsDeleteVirtLn', none, none, {})
    -- highlight('GitSignsStagedAddCul', none, none, {})
    -- highlight('GitSignsStagedChange', none, none, {})
    -- highlight('GitSignsStagedDelete', none, none, {})
    -- highlight('GitSignsTopdeleteCul', none, none, {})
    -- highlight('GitSignsUntrackedCul', none, none, {})
    -- highlight('GitSignsDeletePreview', none, none, {})
    -- highlight('GitSignsChangeLnInline', none, none, {})
    -- highlight('GitSignsChangedeleteLn', none, none, {})
    -- highlight('GitSignsChangedeleteNr', none, none, {})
    -- highlight('GitSignsDeleteLnInline', none, none, {})
    -- highlight('GitSignsStagedChangeLn', none, none, {})
    -- highlight('GitSignsStagedChangeNr', none, none, {})
    -- highlight('GitSignsStagedDeleteNr', none, none, {})
    -- highlight('GitSignsChangedeleteCul', none, none, {})
    -- highlight('GitSignsStagedChangeCul', none, none, {})
    -- highlight('GitSignsStagedDeleteCul', none, none, {})
    -- highlight('GitSignsStagedTopdelete', none, none, {})
    -- highlight('GitSignsStagedUntracked', none, none, {})
    highlight('GitSignsCurrentLineBlame', 3, 16, {})
    -- highlight('GitSignsStagedTopdeleteNr', none, none, {})
    -- highlight('GitSignsStagedUntrackedLn', none, none, {})
    -- highlight('GitSignsStagedUntrackedNr', none, none, {})
    -- highlight('GitSignsDeleteVirtLnInLine', none, none, {})
    -- highlight('GitSignsStagedChangedelete', none, none, {})
    -- highlight('GitSignsStagedTopdeleteCul', none, none, {})
    -- highlight('GitSignsStagedUntrackedCul', none, none, {})
    -- highlight('GitSignsStagedChangedeleteLn', none, none, {})
    -- highlight('GitSignsStagedChangedeleteNr', none, none, {})
    -- highlight('GitSignsStagedChangedeleteCul', none, none, {})


    -- Oil
    highlight('OilHidden', 5, 17, {})

    -- TODO
    highlight('Todo', 17, none, {})

    -- FIX:
    highlight('TodoBgFIX', none, 11, {})
    highlight('TodoFgFIX', 11, none, {})
    highlight('TodoSignFIX', 11, none, {})

    -- HACK:
    highlight('TodoBgHACK', none, 15, {})
    highlight('TodoFgHACK', 15, none, {})
    highlight('TodoSignHACK', 15, none, {})

    -- NOTE:
    highlight('TodoBgNOTE', none, 12, {})
    highlight('TodoFgNOTE', 12, none, {})
    highlight('TodoSignNOTE', 12, none, {})

    -- PERF:
    highlight('TodoBgPERF', 17, 16, {})
    highlight('TodoFgPERF', 16, none, {})
    highlight('TodoSignPERF', 16, none, {})

    -- TEST:
    highlight('TodoBgTEST', none, 14, {})
    highlight('TodoFgTEST', 14, none, {})
    highlight('TodoSignTEST', 14, none, {})

    -- TODO:
    highlight('TodoBgTODO', 17, 6, {})
    highlight('TodoFgTODO', 6, none, {})
    highlight('TodoSignTODO', 6, none, {})

    -- WARN:
    highlight('TodoBgWARN', none, 9, {})
    highlight('TodoFgWARN', 9, none, {})
    highlight('TodoSignWARN', 9, none, {})



    -- highlight('AerialKey', none, none, {})
    -- highlight('AerialEnum', none, none, {})
    -- highlight('AerialFile', none, none, {})
    -- highlight('AerialLine', none, none, {})
    -- highlight('AerialNull', none, none, {})
    -- highlight('AerialArray', none, none, {})
    -- highlight('AerialClass', none, none, {})
    -- highlight('AerialEvent', none, none, {})
    -- highlight('AerialField', none, none, {})
    -- highlight('AerialGuide', none, none, {})
    highlight('AerialGuide1', 5, none, {})
    highlight('AerialGuide2', 5, none, {})
    highlight('AerialGuide3', 5, none, {})
    highlight('AerialGuide4', 5, none, {})
    highlight('AerialGuide5', 5, none, {})
    highlight('AerialGuide6', 5, none, {})
    highlight('AerialGuide7', 5, none, {})
    highlight('AerialGuide8', 5, none, {})
    highlight('AerialGuide9', 5, none, {})
    -- highlight('AerialLineNC', none, none, {})
    -- highlight('AerialMethod', none, none, {})
    -- highlight('AerialModule', none, none, {})
    -- highlight('AerialNormal', none, none, {})
    -- highlight('AerialNumber', none, none, {})
    -- highlight('AerialObject', none, none, {})
    -- highlight('AerialString', none, none, {})
    -- highlight('AerialStruct', none, none, {})
    -- highlight('AerialBoolean', none, none, {})
    -- highlight('AerialKeyIcon', none, none, {})
    -- highlight('AerialPackage', none, none, {})
    -- highlight('AerialPrivate', none, none, {})
    -- highlight('AerialConstant', none, none, {})
    -- highlight('AerialEnumIcon', none, none, {})
    -- highlight('AerialFileIcon', none, none, {})
    -- highlight('AerialFunction', none, none, {})
    -- highlight('AerialNullIcon', none, none, {})
    -- highlight('AerialOperator', none, none, {})
    -- highlight('AerialProperty', none, none, {})
    -- highlight('AerialVariable', none, none, {})
    -- highlight('AerialArrayIcon', none, none, {})
    -- highlight('AerialClassIcon', none, none, {})
    -- highlight('AerialEventIcon', none, none, {})
    -- highlight('AerialFieldIcon', none, none, {})
    -- highlight('AerialInterface', none, none, {})
    -- highlight('AerialNamespace', none, none, {})
    -- highlight('AerialProtected', none, none, {})
    -- highlight('AerialEnumMember', none, none, {})
    -- highlight('AerialMethodIcon', none, none, {})
    -- highlight('AerialModuleIcon', none, none, {})
    -- highlight('AerialNumberIcon', none, none, {})
    -- highlight('AerialObjectIcon', none, none, {})
    -- highlight('AerialStringIcon', none, none, {})
    -- highlight('AerialStructIcon', none, none, {})
    -- highlight('AerialBooleanIcon', none, none, {})
    -- highlight('AerialConstructor', none, none, {})
    -- highlight('AerialNormalFloat', none, none, {})
    -- highlight('AerialPackageIcon', none, none, {})
    -- highlight('AerialConstantIcon', none, none, {})
    -- highlight('AerialFunctionIcon', none, none, {})
    -- highlight('AerialOperatorIcon', none, none, {})
    -- highlight('AerialPropertyIcon', none, none, {})
    -- highlight('AerialVariableIcon', none, none, {})
    -- highlight('AerialInterfaceIcon', none, none, {})
    -- highlight('AerialNamespaceIcon', none, none, {})
    -- highlight('AerialTypeParameter', none, none, {})
    -- highlight('AerialEnumMemberIcon', none, none, {})
    -- highlight('AerialConstructorIcon', none, none, {})
    -- highlight('AerialTypeParameterIcon', none, none, {})
end

return Theme
