module ResponseHelper
  def json_response_ok(message, data)
    json: {status: 'SUCCESS', message:message, data:data},status: :ok
  end

  def json_response_error(message, data)
    json: {status: 'ERROR', message:message, data:data.errors},status: :unprocessable_entity
  end
end
