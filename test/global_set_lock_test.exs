defmodule GlobalSetLockTest do
  use ExUnit.Case

  setup do
    other_pid =
      spawn(fn ->
        receive do
          :kill ->
            # IO.inspect("killed")
            nil
        end
      end)

    on_exit(fn -> send(other_pid, :kill) end)

    %{other_pid: other_pid}
  end

  describe "lock/1" do
    test "return true" do
      assert true == GlobalSetLock.lock(self())
    end

    test "return false when other process locked", %{other_pid: other_pid} do
      true = GlobalSetLock.lock(other_pid)
      assert false == GlobalSetLock.lock(self())
    end

    test "return :ok after unlock/1", %{other_pid: other_pid} do
      true = GlobalSetLock.lock(other_pid)
      false = GlobalSetLock.lock(self())

      true = GlobalSetLock.unlock(other_pid)

      # can lock again after unlock
      assert true == GlobalSetLock.lock(self())
    end
  end

  describe "unlock/1" do
    test "return true even if double unlocked" do
      true = GlobalSetLock.unlock(self())

      assert true == GlobalSetLock.unlock(self())
    end
  end
end
