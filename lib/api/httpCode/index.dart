class HttpCode {
  // Service response code for success
  static const CODE_SUCCESS = 'SUCCESS';

  // Service response code for Error
  static const CODE_ERROR = 'ERROR';
  
  // Code is Error
  static const CODE_IS_ERROR = 'CODE_IS_ERROR';
  
  // Code is expired
  static const CODE_IS_EXPIRED = 'CODE_IS_EXPIRED';
  
  // phone or code is error
  static const PHONE_OR_CODE_IS_ERROR = 'PHONE_OR_CODE_IS_ERROR';
  
  // phone is required
  static const PHONE_IS_REQUIRED = 'PHONE_IS_REQUIRED';
  
  // phone is error
  static const PHONR_IS_ERROR = 'PHONR_IS_ERROR';
  
  // Code for has no network
  static const CODE_NO_NETWORK = 'NO_NETWORK';
  
  // Code for cancel
  static const CODE_CANCEL = 'CODE_CANCEL';
  
  // User is not exist
  static const USER_IS_NOT_EXIST = 'USER_IS_NOT_EXIST';
  
  // Patient can not authorize agent
  static const PERMISSION_DENIED = 'PERMISSION_DENIED';
  
  // Code for invalid user name or password when login
  static const CODE_INVALID_USERNAME_OR_PASSWORD = 'INVALID_USERNAME_OR_PASSWORD';
  
  // Code for user account has been locked when login
  static const CODE_USER_HAS_BEEN_LOCKED = 'USER_HAS_BEEN_LOCKED';
  
  // Code for user account role not found when login
  static const USER_ROLE_NOT_FOUND = 'USER_ROLE_NOT_FOUND';
  
  // Code for user password not found when edit password
  static const USER_NOT_FOUND = 'USER_NOT_FOUND';
  
  // Code for add name has existed
  static const NAME_HAS_EXISTED = 'NAME_HAS_EXISTED';
  
  // Code for add code has existed
  static const CODE_HAS_EXISTED = 'CODE_HAS_EXISTED';
  
  // Code for add user has existed
  static const PHONE_HAS_EXISTED = 'PHONE_HAS_EXISTED';
  
  // Code for add client phone has existed
  static const CLIENT_PHONE_EXISTS = 'CLIENT_PHONE_EXISTS';
  
  // Code for add client name has existed
  static const CLIENT_NAME_EXISTS = 'CLIENT_NAME_EXISTS';
  
  // Code for add patient has existed
  static const PHONE_IS_EXIST = 'PHONE_IS_EXIST';
  
  // Code for phone is invalid
  static const PHONE_IS_INVALID = 'PHONE_IS_INVALID';
  
  // Code for vsiting is not found
  static const VISITING_IS_NOT_FOUND = 'VISITING_IS_NOT_FOUND';
  
  // Code for user exists with the same trial and visiting
  static const USER_EXISTS_WITH_THE_SAME_TRIAL_AND_VISITING = 'USER_EXISTS_WITH_THE_SAME_TRIAL_AND_VISITING';
  
  // Code for user visiting trial exist
  static const USER_VISITING_TRAIL_EXIST = 'USER_VISITING_TRAIL_EXIST';
  
  // Code for visiting record is not found
  static const VISITING_RECORD_IS_NOT_FOUND = 'VISITING_RECORD_IS_NOT_FOUND';
  
  // Code for stage can only be 4 or 5
  static const STAGE_IS_ERROR = 'STAGE_IS_ERROR';
  
  // The commissioner has no authority to access the web
  static const INVALID_ROLE = 'INVALID_ROLE';
  
  // Code for user client trail exist
  static const USER_CLIENT_TRAIL_EXIST = 'USER_CLIENT_TRAIL_EXIST';
  
  // Code for department exist
  static const DEPARTMENT_HAS_EXISTED = 'DEPARTMENT_HAS_EXISTED';
  
  // Code for user already exists in the trial with the same client
  static const USER_CLIENT_TRAIL_MUST_BE_UNIQUE = 'USER_CLIENT_TRAIL_MUST_BE_UNIQUE';
  
  // Code for phoneName has existed
  static const PHONENAME_HAS_EXISTED = 'PHONENAME_HAS_EXISTED';
  
  // get disease list failed
  static const GET_DISEASE_LIST_FAILED = 'GET_DISEASE_LIST_FAILED';
  
  // create disease failed
  static const CREATE_DISEASE_FAILED = 'CREATE_DISEASE_FAILED';
  
  // disease is existed
  static const DISEASE_EXISTED = 'DISEASE_EXISTED';
  
  // get disease failed
  static const GET_DISEASE_FAILED = 'GET_DISEASE_FAILED';
  
  // update disease failed
  static const UPDATE_DISEASE_FAILED = 'UPDATE_DISEASE_FAILED';
  
  // update disease sort failed
  static const UPDATE_DISEASE_SORT_FAILED = 'UPDATE_DISEASE_SORT_FAILED';
  
  // disease is deleted
  static const DISEASE_IS_DELETED = 'DISEASE_IS_DELETED';
  
  // delete disease failed
  static const DISEASE_DELETED_FAILED = 'DISEASE_DELETED_FAILED';
  
  // sort has existed
  static const SORT_HAS_EXISTED = 'SORT_HAS_EXISTED';
  
  // screen table is not found
  static const SCREEN_TABLE_IS_NOT_EXIST = 'SCREEN_TABLE_IS_NOT_EXIST';
  
  // trial subject is not exist
  static const TRIAL_SUBJECT_IS_NOT_EXIST = 'TRIAL_SUBJECT_IS_NOT_EXIST';
  
  // add site departments failed
  static const ADD_DEPARTMENTS_FAILED = 'ADD_DEPARTMENTS_FAILED';
  
  // create and edit disease failed
  static const DUPLICATE_KEY = 'DUPLICATE_KEY';
  
  // edit trial failed
  static const TRIAL_SUBJECT_HAS_EXISTED = 'TRIAL_SUBJECT_HAS_EXISTED';
  
  // get task failed
  static const USER_TRIAL_NOT_FOUND = 'USER_TRIAL_NOT_FOUND';
  
  // version code error
  static const VERSION_CODE_ERROR = 'VERSION_CODE_ERROR';
  
  // update user role error
  static const UPDATE_USER_ORG_ROLE_ERROR = 'UPDATE_USER_ORG_ROLE_ERROR';
  
  // update app package version code error
  static const MUST_UPLOAD_PACKAGE = 'MUST_UPLOAD_PACKAGE';
}

