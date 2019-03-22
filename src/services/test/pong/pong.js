import { success } from '_core/utils/response';
import { ErrorHandler } from '_core/utils/error-handling';

const handler = async (event, context, callback) => {

  try {
    return callback(null, success({ pong: 'serverless: pong' }));
  } catch (e) {
    const errorMessage = await ErrorHandler(e, event, context);
    return callback(null, errorMessage);
  }
};

export { handler };