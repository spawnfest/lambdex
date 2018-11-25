defmodule LambdexCore.Execution do
@moduledoc """
The Lambda Execution
"""

defstruct lambda_id: nil,
  executed_at: nil,
  result: nil,
  output: "",
  sign: nil,
  duration: 0,
  max_cpu_used: 0,
  request_id: "",
  status: nil,
  error: nil

end
