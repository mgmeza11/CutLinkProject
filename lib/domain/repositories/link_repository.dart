import 'package:cut_link_project/data/datasources/remote/link_remote_data_source.dart';

class LinkRepository{
  late LinkRemoteDataSource remoteDataSource;

  LinkRepository() {
    remoteDataSource = LinkRemoteDataSource();
  }

  Future<String> getShortLink(String link) async {
    String shortLink = await remoteDataSource.getShortLink(link);
    return Future.value(shortLink);
  }
}