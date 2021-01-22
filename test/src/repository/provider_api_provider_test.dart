import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/api_key.dart';
import 'package:prozone/src/resources/provider_api_provider.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group("ProviderApiProvider test", () {
    test("fetchProviderList success test", () async {
      var providerRepo = ProviderApiProvider();
      var mockClient = MockDio();
      when(mockClient.get(BASE_URL + "/providers"))
          .thenAnswer((_) async => Response(
                data:
                    '[{"id": 77, "name": "New Provider Name", "description": null, "rating": null,"address": "Lagos", "active_status": "Pending","provider_type": { "id": 2, "name": "Gym", "created_at": "2020-07-11T07:20:23.191Z", "updated_at": "2020-07-11T07:20:23.191Z"}, "created_at": "2021-01-21T09:59:25.037Z", "updated_at": "2021-01-21T09:59:25.081Z","state": { "id": 1,"name": "Lagos","created_at": "2020-07-11T07:54:37.652Z","updated_at": "2020-07-11T07:54:37.652Z"},"images": []},{"id": 43,"name": "Test Provider","description": "A Description of the Provider","rating": 1,"address": "Somewhere only we know","active_status": "Pending","provider_type": {"id": 1,"name": "Hospital","created_at": "2020-07-11T07:20:17.680Z","updated_at": "2020-07-11T07:20:17.680Z"},"created_at": "2020-07-11T14:09:23.330Z","updated_at": "2020-07-11T14:09:23.336Z","state": {"id": 1,"name": "Lagos","created_at": "2020-07-11T07:54:37.652Z","updated_at": "2020-07-11T07:54:37.652Z"},"images": [{"id": 24,"name": "IMG_0002","alternativeText": null,"caption": null,"width": 4288,"height": 2848,"formats": {"large": {"ext": ".bin","url": "https://res.cloudinary.com/maxii/image/upload/v1611212028/large_IMG_0002_c114d5c072.jpg","hash": "large_IMG_0002_c114d5c072","mime": "application/octet-stream", "path": null,"size": 90.33,"width": 1000,"height": 664,"provider_metadata": {"public_id": "large_IMG_0002_c114d5c072","resource_type": "image"}},"small": {"ext": ".bin","url": "https://res.cloudinary.com/maxii/image/upload/v1611212029/small_IMG_0002_c114d5c072.jpg","hash": "small_IMG_0002_c114d5c072","mime": "application/octet-stream","path": null,"size": 34.02,"width": 500,"height": 332,"provider_metadata": {"public_id": "small_IMG_0002_c114d5c072","resource_type": "image"}},"medium": {"ext": ".bin","url": "https://res.cloudinary.com/maxii/image/upload/v1611212029/medium_IMG_0002_c114d5c072.jpg","hash": "medium_IMG_0002_c114d5c072","mime": "application/octet-stream","path": null,"size": 60.99,"width": 750,"height": 498,"provider_metadata": {"public_id": "medium_IMG_0002_c114d5c072","resource_type": "image"}},"thumbnail": {"ext": ".bin","url": "https://res.cloudinary.com/maxii/image/upload/v1611212027/thumbnail_IMG_0002_c114d5c072.jpg","hash": "thumbnail_IMG_0002_c114d5c072","mime": "application/octet-stream","path": null,"size": 11.59,"width": 235,"height": 156,"provider_metadata": {"public_id": "thumbnail_IMG_0002_c114d5c072", "resource_type": "image"}}},"hash": "IMG_0002_c114d5c072","ext": ".bin","mime": "application/octet-stream","size": 1098.1,"url": "https://res.cloudinary.com/maxii/image/upload/v1611212027/IMG_0002_c114d5c072.jpg","previewUrl": null,"provider": "cloudinary","provider_metadata": {"public_id": "IMG_0002_c114d5c072","resource_type": "image"},"created_at": "2021-01-21T06:53:49.649Z","updated_at": "2021-01-21T06:53:49.649Z"}]},}]',
              ));
      expect(await providerRepo.fetchProviderList(),
          isInstanceOf<SuccessState<List<ProviderModel>>>());
    });
  });
}
