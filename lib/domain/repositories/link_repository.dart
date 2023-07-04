import 'package:cut_link_project/data/datasources/local/link_local_data_source.dart';
import 'package:cut_link_project/data/datasources/remote/link_remote_data_source.dart';

import '../models/LinkData.dart';

class LinkRepository{
  late LinkRemoteDataSource remoteDataSource;
  late LinkLocalDataSource localDataSource;

  LinkRepository() {
    remoteDataSource = LinkRemoteDataSource();
    localDataSource = LinkLocalDataSource();
  }

  Future<String> getShortLink(String link) async {
    String shortLink = await remoteDataSource.getShortLink(link);
    addLink(LinkData(link: shortLink));
    return Future.value(shortLink);
  }

  Future<List<LinkData>> getAllLinks() async =>
      await localDataSource.getAllLinks();

  Future<void> addLink(LinkData linkData) async =>
      await localDataSource.addLink(linkData);

}