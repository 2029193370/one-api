/** 放宽正文行宽，避免历史提交在 CI 中因单行过长失败 */
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'body-max-line-length': [0],
  },
};
