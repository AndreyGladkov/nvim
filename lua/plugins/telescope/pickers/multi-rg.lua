-- ╭──────────────────────────────────────────────────────────╮
-- │ This is a custom telescope ripgrep picker that           │
-- │  accepts predefined shortcuts after two spaces in input. │
-- │                                                          │
-- │ Those shortcuts will filter files by selected            │
-- │  extension only.                                         │
-- │                                                          │
-- │ Default keybinding is <S-P>                              │
-- ╰──────────────────────────────────────────────────────────╯

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local builtin    = require('telescope.builtin')

local flatten = vim.tbl_flatten

local function is_table(t) return type(t) == 'table' end
local function is_string(t) return type(t) == 'string' end

local last_search = nil
local last_type = nil

return function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.layout_strategy = 'vertical'
  opts.layout_config = { width=0.99, height=0.99 }

  opts.shortcuts = opts.shortcuts
      or {
        ["c"] = "*.c",
        ["js"] = "*.{js}",
        ["json"] = "*.json",
        ["l"] = "*.lua",
        ["lua"] = "*.lua",
        ["less"] = "*.less",
        ["css"] = "*.css",
        ["md"] = "*.md",
        ["mdx"] = "*.mdx",
        ["styles"] = "{styles.tsx,styles.ts,styles.js,*.styles.tsx,*.styles.ts,*.styles.js}",
        ["stories"] = "{stories.tsx,stories.ts,stories.js,*.stories.tsx,*.stories.ts,*.stories.js}",
        ["test"] = "*{.test.tsx,.test.ts,.test.js,-test.tsx,-test.ts,-test.js}",
        ["tests"] = "*{.test.tsx,.test.ts,.test.js,-test.tsx,-test.ts,-test.js}",
        ["typescript"] = "*.ts",
        ["ts"] = {
          "*.{ts}",
          "!*{.test.ts,-test.ts}"
        },
        ["tsx"] = {
          "*.tsx",
          "!*{.test.tsx,.test.ts,-test.tsx,-test.ts}"
        },
        ["xml"] = "*.xml",
        ["xsl"] = "*.xsl",
        ["py"] = "*.py",
        ["sh"] = "*.sh",
      }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_async_job {
    command_generator = function(prompt)
      if not (not prompt or prompt == "") then
        last_search = prompt
      end

      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ")

      local args = { "rg" }

      if not prompt_split[2] then
          return nil
      end

      if prompt_split[1] then
        table.insert(args, "-e")
        table.insert(args, prompt_split[1])
      end

      if prompt_split[2] and is_table(opts.shortcuts[prompt_split[2]]) then
        local pattern

        for _, value in pairs(opts.shortcuts[prompt_split[2]]) do
          table.insert(args, "-g")
          if opts.shortcuts[prompt_split[2]] then
            pattern = value
          else
            pattern = prompt_split[2]
          end

          table.insert(args, string.format(opts.pattern, pattern))
        end
      end

      if prompt_split[2] and is_string(opts.shortcuts[prompt_split[2]]) then
        table.insert(args, "-g")

        local pattern
        if opts.shortcuts[prompt_split[2]] then
          pattern = opts.shortcuts[prompt_split[2]]
        else
          pattern = prompt_split[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      if prompt_split[2] and opts.shortcuts[prompt_split[2]] == nil then
        table.insert(args, "-g")
        table.insert(args, string.format(opts.pattern, prompt_split[2]))
      end


      return flatten {
        args,
        { "-F" , "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  if opts.type == 'project_files' then
    require('plugins.telescope').project_files(opts)
    last_type = opts.type
  elseif opts.type == 'buffers' then
    require('plugins.telescope').buffers(opts)
    last_type = opts.type
  else 
      if not(not last_search or last_search == "") and last_type ~= 'project_files' then
        opts.initial_mode = 'normal'
        builtin.resume(opts);
      else 
        pickers.new(opts, {
          debounce = 100,
          prompt_title = "Live Grep",
          finder = custom_grep,
          previewer = conf.grep_previewer(opts),
          sorter = require("telescope.sorters").empty(),
        }):find()
      end
  end
  last_type = opts.type;
end
