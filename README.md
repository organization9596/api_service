# api_service
This package use dio to call  api, handle error, provide flavor.
## Getting Started

### Step1:
Create di using getIt, must create Api Service class, and init ServerConfig provide information via ServiceConfigBuilder.
``` dart
import 'package:api_service/screentest/api/github_api.dart';
import 'package:api_service/screentest/api/github_api_mock.dart';
import 'package:api_service/screentest/main.dart';
import 'package:api_service/service/service_config.dart';
import 'package:get_it/get_it.dart';

GetIt getItProvider = GetIt.instance;

void setUpApi() {
  _serviceApi();
  _apiProvider();
  _apiMockProvider();
}

var builder = ServiceConfigBuilder()
  ..timeOut = 3000
  ..developBaseUrl = GITHUB_BASE_URL
  ..mockBaseUrl = GITHUB_BASE_URL
  ..mockBaseUrl = GITHUB_BASE_URL;

void _serviceApi() {
  getItProvider.registerSingleton(builder);
  getItProvider.registerFactory(
      () => ServerConfig(getItProvider.get<ServiceConfigBuilder>()));
}

void _apiProvider() {
  getItProvider.registerFactory<GithubApi>(() => GithubApi());
}

void _apiMockProvider() {
  getItProvider.registerFactory<GithubApiMock>(() => GithubApiMock());
}
```
### Step 2: setUpDevFlavor. In main funtion of app

 ```dart
 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   \\\ set up dependency of app
   setUpApi();
   \\\ init flavor
   setUpDevFlavor(getItProvider.get<ServerConfig>());
   var store = await createStore();
   runApp(TodoApp(
     store: store,
   ));
   callApi();
 }
 \\\ Package provide 3 Flavor option  Mock, Develop,Product
 void setUpDevFlavor(ServerConfig serverConfig) {
    FlavorConfig(
        flavor: Flavor.DEVELOP, values: getDevelopFlavorValue(serverConfig));
  }
 ```
 ### Step3 :setup Api Service  & call api in repo

 ```dart
@RestApi(baseUrl: "")
abstract class GithubApi {
  factory GithubApi() {
    var serviceConfig = getItProvider<ServerConfig>();
    return _GithubApi(serviceConfig.getRestClient(),
        baseUrl: FlavorConfig.instance.values.baseUrl);
  }

  @GET("search/repositories?sort=stars")
  Future<RepoSearchResponse> searchRepos(@Query("q") String query,
      @Query("page") int page, @Query("per_page") int itemsPerPage);
}
```

```dart
class GithubRepository extends BaseRepository {
  final GithubApi? _githubApi = getItProvider.get<GithubApi>();
  final GithubApiMock? _githubApiMock = getItProvider.get<GithubApiMock>();

  @override
  Future<AppResult<List<GithubEntity>>> getGithubRepos(String query) async {
    AppResult<List<GithubEntity>> res =
        await safeApiCall<List<GithubEntity>>(callFunctionMock: () async {
      return await _githubApiMock?.searchRepos("android", 1, 10).then((value) => value.items);
    }, callFunctionDevelop: () async {
      return await _githubApi?.searchRepos("android", 1, 10).then((value) => value.items);;
    }, callFunctionProduct: () async {
      return await _githubApi?.searchRepos("android", 1, 10);
    });
    return res;
  }
}
```