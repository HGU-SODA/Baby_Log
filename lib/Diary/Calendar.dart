import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DiaryPage.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();
  late CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, Map<String, dynamic>> _dateEntries = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadDiaryEntries(); // Load diary entries from Firestore
  }

  Future<void> _loadDiaryEntries() async {
    final uid = 'user-id'; // Replace with actual user ID
    _dateEntries = await loadDiaryEntries(uid);
    setState(() {});
  }

  void _onMonthChange(int direction) {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month + direction,
        1,
      );
      if (_focusedDay.month > 12) {
        _focusedDay = DateTime(_focusedDay.year + 1, 1, 1);
      } else if (_focusedDay.month < 1) {
        _focusedDay = DateTime(_focusedDay.year - 1, 12, 1);
      }
      if (_selectedDate != null &&
          (_selectedDate!.month != _focusedDay.month ||
              _selectedDate!.year != _focusedDay.year)) {
        _selectedDate = DateTime(_focusedDay.year, _focusedDay.month, 1);
      }
    });
  }

  void _selectDate(DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryPage(
          date: date,
          initialImageUrl: _dateEntries[date]?['imageUrl'], // Get image URL
          initialNote: _dateEntries[date]?['note'],
          onSave: (imageUrl, note) {
            setState(() {
              _dateEntries[date] = {
                'imageUrl': imageUrl,
                'note': note,
              };
            });
          },
          onDelete: () {
            setState(() {
              _dateEntries.remove(date);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat monthFormat = DateFormat('MMMM');
    final DateFormat yearFormat = DateFormat('yyyy');
    final DateFormat selectedDateFormat = DateFormat('yyyy.MM.dd');
    String formattedDay =
        _selectedDate != null ? DateFormat('d').format(_selectedDate!) : '';
    String formattedMonth = _focusedDay != null
        ? monthFormat.format(_focusedDay)
        : 'No month selected!';
    String formattedYear =
        _focusedDay != null ? yearFormat.format(_focusedDay) : '';
    String formattedSelectedDate =
        _selectedDate != null ? selectedDateFormat.format(_selectedDate!) : '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Color(0XFFFFDCB2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () => _onMonthChange(-1),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              formattedMonth,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              formattedYear,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              formattedSelectedDate,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () => _onMonthChange(1),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: _selectedDate!,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            cancelText: 'CANCEL',
                            confirmText: 'OK',
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Color(0XFFFFBA69),
                                  colorScheme: const ColorScheme.light(
                                      primary: Color(0XFFFFBA69)),
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  contentPadding: EdgeInsets.zero,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  content: SizedBox(
                                    width: 330,
                                    height: 500,
                                    child: child,
                                  ),
                                ),
                              );
                            }).then((pickedDate) {
                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _focusedDay = pickedDate;
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 33),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _selectDate(selectedDay);
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                headerVisible: false,
                // 요일 텍스트 설정
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  weekendStyle: TextStyle(
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  // 선택된 날짜
                  selectedBuilder: (context, date, focusedDay) {
                    bool hasImage = _dateEntries[date]?['imageUrl'] != null;

                    return Container(
                      width: 36,
                      height: 37,
                      decoration: BoxDecoration(
                        color: hasImage
                            ? null
                            : Color(0XFFF5FBF6), // 사진이 없는데 선택됐으면 회색 적용
                        image: hasImage
                            ? DecorationImage(
                                image: NetworkImage(
                                    _dateEntries[date]!['imageUrl']),
                                fit: BoxFit.cover,
                              )
                            : null,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: hasImage
                                ? Color(0XFFFFB052)
                                : Color(0XFFD5DBD7), // 사진이 있으면 주황색, 없으면 회색 테두리
                            width: 2),
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: hasImage
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.black // 사진 여부에 따라 날짜 색이 바뀜
                              ),
                        ),
                      ),
                    );
                  },
                  // 날짜 기본 스타일
                  defaultBuilder: (context, date, focusedDay) {
                    bool hasImage = _dateEntries[date]?['imageUrl'] != null;

                    return Container(
                      width: 36,
                      height: 37,
                      decoration: BoxDecoration(
                        image: hasImage
                            ? DecorationImage(
                                image: NetworkImage(
                                    _dateEntries[date]!['imageUrl']),
                                fit: BoxFit.cover,
                              )
                            : null,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: hasImage
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  // 오늘 날짜
                  todayBuilder: (context, date, _) {
                    bool hasImage = _dateEntries.containsKey(date);
                    return Container(
                      width: 36,
                      height: 37,
                      decoration: BoxDecoration(
                        image: hasImage
                            ? DecorationImage(
                                image: NetworkImage(
                                    _dateEntries[date]!['imageUrl']),
                                fit: BoxFit.cover,
                              )
                            : null,
                        shape: BoxShape.circle,
                        color: Color(0XFFFFDCB2),
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: hasImage
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0XFFFFDCB2),
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                rowHeight: 65,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(156, 14, 59, 27),
            child: Image.asset(
              'assets/엄마와 아기.png',
              width: 215,
              height: 193,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

Future<Map<DateTime, Map<String, dynamic>>> loadDiaryEntries(String uid) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('diaries')
        .doc(uid)
        .collection('entries')
        .get();
    final Map<DateTime, Map<String, dynamic>> entries = {};
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      final date = DateTime.parse(doc.id);
      entries[date] = {
        'note': data['note'],
        'imageUrl': data['imageUrl'],
      };
    }
    return entries;
  } catch (e) {
    print('Error loading diary entries: $e');
    return {};
  }
}
