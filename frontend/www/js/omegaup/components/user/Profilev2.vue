<template>
    <div class="container-lg" style="margin-top: 30px;">
        <div class="row">
            <div class="col-md-2 no-right-padding">
                <div class="card">
                    <div class="card-body">
                    <div class="img-thumbnail rounded-circle bottom-margin">
                        <img v-bind:src="profile.gravatar_92" />
                    </div>
                    <h4 class="card-title text-center" style="font-size: 13px;">
                        {{ profile.rankinfo.rank &gt; 0 ? `#${profile.rankinfo.rank} - `:
                    '' }}
                        <omegaup-user-username
                        v-bind:classname="profile.classname"
                        v-bind:username="profile.username"
                        ></omegaup-user-username>

                        <p>{{profile.email}} </p>
                        <p>{{profile.school}} </p>
                        <img
                        class="rounded-circle"
                        height="20"
                        v-bind:src="
                            `/media/flags/${profile.country_id.toLowerCase()}.png`
                        "
                        v-bind:title="profile.country_id"
                        v-if="profile.country_id"
                        width="25"
                        />

                    </h4>
                    <div class="text-center" v-if="profile.email">
                        <a class="btn btn-primary btn-sm" href="/profile/edit/">{{
                        T.profileEdit
                        }}</a>
                    </div>

                    </div>
                </div>
            </div>
            <div class="col-md-10 card no-right-padding no-left-padding">
                <div class="card-header">
                    <nav>
                        <div class="nav nav-tabs" role="tablist">
                            <a class="nav-item nav-link active" data-toggle="tab" href="#nav-badges" role="tab" aria-controls="nav-badges" aria-selected="true" v-on:click="selectedTab = 'badges'">{{T.wordsBadgesObtained}}</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#nav-problems" role="tab" aria-controls="nav-problems" aria-selected="false" v-on:click="selectedTab = 'problems'">{{ T.wordsProblems }}</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#nav-contests" role="tab" aria-controls="nav-contests" aria-selected="false" v-on:click="selectedTab = 'contests'">{{ T.profileContests }}</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#nav-user-info" role="tab" aria-controls="nav-user-info" aria-selected="false" v-on:click="selectedTab = 'data'">{{T.wordsPersonalData}}</a>
                            <a class="nav-item nav-link" data-toggle="tab" href="#nav-charts" role="tab" aria-controls="nav-charts" aria-selected="false" v-on:click="selectedTab = 'charts'">{{T.wordsStatistics}}</a>

                        </div>
                    </nav>
                    <div class="tab-content">
                        <div class="tab-pane fade show active" role="tabpanel" aria-labelledby="nav-badges-tab">
                            <omegaup-badge-list
                                v-bind:all-badges="profileBadges"
                                v-bind:show-all-badges-link="true"
                                v-bind:visitor-badges="visitorBadges"
                                v-if="selectedTab == 'badges'"
                            ></omegaup-badge-list>
                        </div>
                        <div class="tab-pane fade" role="tabpanel" aria-labelledby="nav-problems-tab" v-if="selectedTab == 'problems'">
                            <omegaup-grid-paginator
                                v-bind:columns="3"
                                v-bind:items="solvedProblems"
                                v-bind:items-per-page="30"
                                v-bind:title="T.profileSolvedProblems"
                            ></omegaup-grid-paginator>
                            <omegaup-grid-paginator
                                v-bind:columns="3"
                                v-bind:items="unsolvedProblems"
                                v-bind:items-per-page="30"
                                v-bind:title="T.profileUnsolvedProblems"
                            ></omegaup-grid-paginator>
                            <omegaup-grid-paginator
                                v-bind:columns="3"
                                v-bind:items="createdProblems"
                                v-bind:items-per-page="30"
                                v-bind:title="T.profileCreatedProblems"
                            ></omegaup-grid-paginator>
                        </div>
                        <div class="tab-pane fade" role="tabpanel" aria-labelledby="nav-contests-tab" v-if="selectedTab == 'contests'">
                            <omegaup-grid-paginator
                                v-bind:columns="1"
                                v-bind:items="contests"
                                v-bind:items-per-page="15"
                                v-bind:title="T.profileContests"
                                v-if="selectedTab == 'profileContests'"
                            >
                                <template slot="table-header">
                                    <thead>
                                        <tr>
                                        <th>{{ T.profileContestsTableContest }}</th>
                                        <th class="numericColumn">{{ T.profileContestsTablePlace }}</th>
                                        </tr>
                                    </thead>
                                </template>
                            </omegaup-grid-paginator>
                        </div>
                        <div class="tab-pane fade" role="tabpanel" aria-labelledby="nav-user-info-tab" v-if="selectedTab == 'data'">
                            <omegaup-user-basicinfo
                                v-bind:profile="profile"
                                v-bind:rank="rank"
                            ></omegaup-user-basicinfo>
                        </div>
                        <div class="tab-pane fade" role="tabpanel" aria-labelledby="nav-charts-tab" v-if="selectedTab == 'charts'">
                            <omegaup-user-charts
                                v-bind:data="charts"
                                v-bind:username="profile.username"
                            ></omegaup-user-charts>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</template>

<style>
.badges-container {
  display: grid;
  justify-content: space-between;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  grid-auto-rows: 180px;
}
a:hover{
  cursor:pointer;
}
</style>

<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator';
import { omegaup } from '../../omegaup';
import T from '../../lang';
import user_BasicInfo from './BasicInfov2.vue';
import user_Username from './Username.vue';
import user_Charts from './Chartsv2.vue';
import badge_List from '../badge/Listv2.vue';
import gridPaginator from '../GridPaginatorv2.vue';
import { Problem, ContestResult } from '../../types.ts';

@Component({
  components: {
    'omegaup-user-basicinfo': user_BasicInfo,
    'omegaup-user-username': user_Username,
    'omegaup-user-charts': user_Charts,
    'omegaup-badge-list': badge_List,
    'omegaup-grid-paginator': gridPaginator,
  },
})
export default class UserProfile extends Vue {
  @Prop() profile!: omegaup.Profile;
  @Prop() contests!: ContestResult[];
  @Prop() solvedProblems!: Problem[];
  @Prop() unsolvedProblems!: Problem[];
  @Prop() createdProblems!: Problem[];
  @Prop() rank!: string;
  @Prop() charts!: any;
  @Prop() profileBadges!: Set<string>;
  @Prop() visitorBadges!: Set<string>;

  T = T;
  columns = 3;
  selectedTab = 'badges';
}
</script>