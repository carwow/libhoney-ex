defmodule Libhoney.SamplingTest do
  use ExUnit.Case

  test "drop? returns false for sample rate of 1" do
    assert false == Libhoney.Sampling.drop?(%{sample_rate: 1})
    assert false == Libhoney.Sampling.drop?(%{sample_rate: 1})
    assert false == Libhoney.Sampling.drop?(%{sample_rate: 1})
    assert false == Libhoney.Sampling.drop?(%{sample_rate: 1})
  end

  test "drop? returns true for N-1 in N" do
    assert true == Libhoney.Sampling.drop?(%{sample_rate: 2})
  end

  test "drop? returns false for 1 in N" do
    assert false == Libhoney.Sampling.drop?(%{sample_rate: 3})
  end
end
