require "middleman-bitballoon/version"
require "middleman-core"
require "middleman-bitballoon/commands"

::Middleman::Extensions.register(:bitballoon) do
  require "middleman-bitballoon/extension"
  ::Middleman::BitBalloon
end
