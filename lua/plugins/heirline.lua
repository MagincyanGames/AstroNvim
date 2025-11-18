-- Ejemplo para tu archivo de configuración de Heirline
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")

    -- Define tu componente personalizado
    local term_indicator = {
      -- provider: función que retorna lo que queremos mostrar
      provider = function()
        if vim.bo.filetype == "toggleterm" then
          local num = vim.b.toggle_number or "?"
          return " T" .. num .. " "
        else
          return ""
        end
      end,
      -- condicional: solo mostrar si es un terminal de toggleterm
      cond = function()
        return vim.bo.filetype == "toggleterm"
      end,
      -- padding, si quieres espacio antes/delante
      padding = { left = 1, right = 1 },
    }

    -- Insertamos el componente en el statusline (donde te convenga)
    -- Por ejemplo, antes del “fill” final, para que vaya hacia el centro/derecha
    table.insert(opts.statusline, term_indicator)
  end,
}

