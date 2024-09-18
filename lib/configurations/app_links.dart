class AppLinks {
  static const baseUrl = 'http://localhost:80/';
  static const baseUrlDev = 'http://localhost:3333/';
  static const baseUrlProd = 'https://control-o5xlbifnea-uc.a.run.app/';
  static const baseUrlStaging =
      'https://control-2025-904810505533.us-central1.run.app/';
}

class AuthLinks {
  static const login = 'auth/login';
  static const logout = 'auth/logout';
  static const refresh = 'auth/refresh';
  static const user = 'users';
  static const userAddRoles = 'users/add-roles';
  static const usersAddSchools = 'users/add-schools';
}

class ControlMissionLinks {
  static const controlMission = 'control-mission';
  static const controlMissionEducationYear = 'education-year';
  static const controlMissionSchool = '$controlMission/school';
  static const studentSeatNumbers = '$controlMission/student-seat-numbers';
}

class EducationYearsLinks {
  static const educationyear = 'education-year';
}

class ExamLinks {
  static const examMission = 'exam-mission';
  static const examMissionControlMission = 'exam-mission/control-mission';
  static const examMissionSubject = 'exam-mission/subject';
  static const examMissionUpload = 'exam-mission/upload';
  static const examRoomNextExam = 'exam-rooms/next-exams';
  static const examRooms = 'exam-rooms';
  static const examRoomsControlMission = 'exam-rooms/control-mission';
  static const examRoomsSchoolClass = 'exam-rooms/school-class';
}

class ProctorsLinks {
  static const getControlMissionByProctor = 'proctor/control-mission';
  static const proctor = 'proctor';
  static const validatePrinciple = '$proctor/validate-principle-password';
}

class SchoolsLinks {
  static const classDesks = 'class-desk';
  static const cohort = 'cohort';
  static const connectSubjectToCohort = '$cohort/Connect-Subject';
  static const disConnectSubjectFromCohort = '$cohort/disconnect-Subject';
  static const getAllSchools = 'schools/all';
  static const getCohortBySchoolType = '$cohort/school-type';
  static const getSchoolsClassesBySchoolId = '$schoolsClasses/school';
  static const grades = 'grades';
  static const gradesSchools = 'grades/school';
  static const schools = 'schools';
  static const schoolsClasses = 'school-classes';
  static const schoolsType = 'school-type';
  static const subject = 'subject';
  static const subjects = 'subjects';
}

class Stage {
  static const stage = 'stage';
}

class StudentsLinks {
  static const markCheatingStudent = '$student/student-cheating';
  static const student = 'student';
  static const studentBarcodes = 'student-barcodes';
  static const studentBarcodesExamMission = 'student-barcodes/exam-mission';
  static const studentBarcodesExamRoom = '$studentBarcodes/exam-room';
  static const studentBarcodesStudent = 'student-barcodes/student';
  static const studentCohort = 'student/cohort';
  static const studentExams = '$student/student-exams';
  static const studentMany = 'student/many';
  static const studentSchool = 'student/school';
  static const studentSeatNumbers = 'student-seat-numbers';
  static const studentSeatNumbersControlMission =
      '$studentSeatNumbers/control-mission';

  static const studentSeatNumbersExamRoom = '$studentSeatNumbers/exam-rooms';
  static const studentSeatNumbersStudent = '$studentSeatNumbers/student';
  static const studentUuid = '/uuid';
  static const studentsClass = 'student/class';
  static const unMarkCheatingStudent = '$student/uncheating-student';
}

class UserRolesSystemsLink {
  static const screen = 'user-roles-systems/screen';
  static const userRolesSystems = 'user-roles-systems';
  static const userRolesSystemsConnectRolesTOScreens =
      'user-roles-systems/connect-roles-to-screens';
}
