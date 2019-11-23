context 'with served_via_locari_delivery' do
      let(:post)          { create(:post_standard_post, :published, :on_list) }
      let(:infeed_deal)   { create(:infeed_deal, cost_per_click: 200) }
      let!(:post_campaign) { create(:post_campaign, id: 44, revenue_per_click: 200, post: post, infeed_deal: infeed_deal) }
      before do
        allow_any_instance_of(Post).to receive(:served_via_locari_delivery?).and_return(true)
        allow_any_instance_of(Post).to receive(:post_campaign).and_return(post_campaign)
      end
      context 'with ios' do
        before do
          env["HTTP_USER_AGENT"] = "LocariMagazine/3.0.0 (iPhone; iOS 7.1.1; Scale/2.00)"
        end
        it "contains 0 in index_value" do
          subject

          assert_response :success

          json_body = JSON.parse(response.body)
          assert_equal 0, json_body['posts'][0]['index']
        end
      end

      context 'without ios' do
        before do
          env["HTTP_USER_AGENT"] = "Dalvik/1.6.0 (Linux; U; Android 4.4.4; Google Nexus 5 - 4.4.4 - API 19 - 1080x1920 Build/KTU84P) LocariAndroid/1.5.0"
        end
        it "contains nil in index_value" do
          subject

          assert_response :success

          json_body = JSON.parse(response.body)
          assert_equal nil, json_body['posts'][0]['index']
        end
      end
    end
