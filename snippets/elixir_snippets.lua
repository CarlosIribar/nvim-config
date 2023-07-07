local ls = require("luasnip")

local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node

ls.snippets.liveview = {
  lv_module = snip({
    trig = "lv",
    name = "LiveView module",
    desc = "LiveView module",
  }, {
    text("defmodule ${WORKSPACE_NAME/(.*)/${1:/pascalcase}/g}Web.${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g} do"),
    text("  use ${WORKSPACE_NAME/(.*)/${1:/pascalcase}/g}Web, :live_view"),
    text("  $0"),
    text("end"),
  }),
  lc_module = snip({
    trig = "lc",
    name = "LiveComponent module",
    desc = "LiveComponent module",
  }, {
    text("defmodule ${WORKSPACE_NAME/(.*)/${1:/pascalcase}/g}Web.${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g} do"),
    text("  use ${WORKSPACE_NAME/(.*)/${1:/pascalcase}/g}Web, :live_component"),
    text("  $0"),
    text("end"),
  }),
  lv_mount = snip({
    trig = "mount",
    name = "LiveView mount function",
    desc = "LiveView mount function",
  }, {
    text("def mount(_params, _session, socket) do"),
    text("  socket ="),
    text("    assign(socket,"),
    text("      ${1:key}: ${2:value}"),
    text("    )"),
    text(""),
    text("  {:ok, socket}"),
    text("end"),
  }),
  lv_render = snip({
    trig = "rend",
    name = "LiveView render function",
    desc = "LiveView render function",
  }, {
    text("def render(assigns) do"),
    text("  ~H\"\"\""),
    text("  ${0}"),
    text("  \"\"\""),
    text("end"),
  }),
  lv_function_component = snip({
    trig = "fc",
    name = "LiveView function component",
    desc = "LiveView function component",
  }, {
    text("def ${1:name}(assigns) do"),
    text("  ~H\"\"\""),
    text("  ${2}"),
    text("  \"\"\""),
    text("end"),
  }),
  lv_handle_event = snip({
    trig = "he",
    name = "LiveView handle_event function",
    desc = "LiveView handle_event function",
  }, {
    text("def handle_event(${1:event}, _, socket) do"),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_handle_event1 = snip({
    trig = "he1",
    name = "LiveView handle_event function with assignment",
    desc = "LiveView handle_event function with assignment",
  }, {
    text("def handle_event(${1:event}, _, socket) do"),
    text("  socket = assign(socket, ${2:key}: ${3:value})"),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_handle_event2 = snip({
    trig = "he2",
    name = "LiveView handle_event function with multiline assignment",
    desc = "LiveView handle_event function with multiline assignment",
  }, {
    text("def handle_event(${1:event}, _, socket) do"),
    text("  socket ="),
    text("    assign(socket,"),
    text("      ${2:key}: ${3:value}"),
    text("    )"),
    text(""),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_handle_info = snip({
    trig = "hi",
    name = "LiveView handle_info function",
    desc = "LiveView handle_info function",
  }, {
    text("def handle_info(${1:message}, socket) do"),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_handle_info1 = snip({
    trig = "hi1",
    name = "LiveView handle_info function with assignment",
    desc = "LiveView handle_info function with assignment",
  }, {
    text("def handle_info(${1:message}, socket) do"),
    text("  socket = assign(socket, ${2:key}: ${3:value})"),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_handle_info2 = snip({
    trig = "hi2",
    name = "LiveView handle_info function with multiline assignment",
    desc = "LiveView handle_info function with multiline assignment",
  }, {
    text("def handle_info(${1:message}, socket) do"),
    text("  socket ="),
    text("    assign(socket,"),
    text("      ${2:key}: ${3:value}"),
    text("    )"),
    text(""),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_handle_params = snip({
    trig = "hp",
    name = "LiveView handle_params function",
    desc = "LiveView handle_params function",
  }, {
    text("def handle_params(${1:params}, _uri, socket) do"),
    text("  {:noreply, socket}"),
    text("end"),
  }),
  lv_heex = snip({
    trig = "h",
    name = "LiveView HEEx template",
    desc = "LiveView HEEx template",
  }, {
    text("~H\"\"\""),
    text("${0}"),
    text("\"\"\""),
  }),
  lv_assign = snip({
    trig = "assign",
    name = "LiveView assign",
    desc = "LiveView assign",
  }, {
    text("socket ="),
    text("  assign(socket,"),
    text("    ${1:key}: ${2:value}"),
    text("  )"),
  }),
  insp = snip({
    trig = "insp",
    name = "Inspect process with a label",
    desc = "Inspect process with a label",
  }, {
    insert("IO.inspect(self(), label: \"${1:label}\")"),
  }),
  map = snip({
    trig = "m",
    name = "Elixir map",
    desc = "Elixir map",
  }, {
    insert("%{\"${1}\" => ${2}}"),
  }),
}

return ls

