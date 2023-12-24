import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/screens/detail_screen.dart';
import 'package:quran/screens/globals.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/list-surah.json');
    print(data);
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _getSurahList(),
      initialData: [],
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return ListView.separated(
            itemBuilder: (context, index) => _surahItem(
                surah: snapshot.data!.elementAt(index), context: context),
            separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: const Color(0x597B80AD).withOpacity(.35),
                ),
            itemCount: snapshot.data!.length);
      }),
    );
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(noSurat: surah.nomor,),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  SvgPicture.asset('assets/svgs/nomor-surah.svg'),
                  SizedBox(
                      height: 36,
                      width: 36,
                      child: Center(
                          child: Text(
                        "${surah.nomor}",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )))
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.namaLatin,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            surah.tempatTurun.name,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: text),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: text),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${surah.jumlahAyat} Ayat",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: text),
                          ),
                        ],
                      )
                    ]),
              ),
              Text(surah.nama,
                  style: GoogleFonts.amiri(
                      color: primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
}
