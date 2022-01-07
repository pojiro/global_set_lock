defmodule GlobalSetLock do
  @moduledoc """
  Documentation for `GlobalSetLock`.
  """

  @spec lock(pid()) :: boolean()
  def lock(pid) when is_pid(pid) do
    # NOTE: :global.set_lock の良いところ
    # > If a process that holds a lock dies, or the node goes down, the locks held by the process are deleted.
    # see. https://www.erlang.org/doc/man/global.html#set_lock-3
    :global.set_lock({NervesJp, pid}, nodes(), 0)
  end

  @spec unlock(pid()) :: true
  def unlock(pid) when is_pid(pid) do
    :global.del_lock({NervesJp, pid}, nodes())
  end

  defp nodes() do
    [Node.self() | Node.list()]
  end
end
