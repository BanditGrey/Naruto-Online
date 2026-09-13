package Processors.Game.Lobby.SystemActivity.Components
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Logics.SLogicsCore;
   import Logics.SystemActivity.TSystemActivity;
   import Logics.SystemActivity.TSystemActivityData;
   import Resources.Constants.CONST_SYSTEMACTIVITY;
   import Resources.Strings.STRING_SYSTEMACTIVITY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUIDateList extends TUIComponent
   {
      
      public static const DETAIL_COUNT:int = 5;
      
      public static const TYPE_HURT:int = TSystemActivity.TYPE_HURT;
      
      public static const TYPE_POINT:int = TSystemActivity.TYPE_POINT;
      
      public static const TYPE_STATUS:int = TSystemActivity.TYPE_STATUS;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_List:Vector.<Sprite>;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FIndex:int;
      
      protected var FInitialized:Boolean;
      
      public function TUIDateList(param1:TUIComponent)
      {
         super(param1);
         this.FMC_List = new Vector.<Sprite>(DETAIL_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = 0;
         while(_loc2_ < DETAIL_COUNT)
         {
            this.FMC_List[_loc2_] = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_List + _loc2_];
            _loc2_++;
         }
         this.FTF_Title = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_TITLE];
         this.FTF_Name = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_Name];
      }
      
      protected function UpdateList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Sprite = null;
         var _loc4_:Vector.<TSystemActivityData> = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TextField = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc3_:TSystemActivity = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FIndex);
         _loc4_ = _loc3_.ActivityData;
         if(_loc3_.ActivityType == TYPE_HURT)
         {
            this.FTF_Title.text = STRING_SYSTEMACTIVITY.FORMAT_TITLE_HURT;
            this.FTF_Name.text = STRING_SYSTEMACTIVITY.FORMAT_PLAYER_NICK;
         }
         else if(_loc3_.ActivityType == TYPE_POINT)
         {
            this.FTF_Title.text = STRING_SYSTEMACTIVITY.FORMAT_TITLE_POINT;
            this.FTF_Name.text = STRING_SYSTEMACTIVITY.FORMAT_ORGANIZATION_NAME;
         }
         else
         {
            this.FTF_Title.text = STRING_SYSTEMACTIVITY.FORMAT_TITLE_STATUS;
            this.FTF_Name.text = STRING_SYSTEMACTIVITY.FORMAT_ORGANIZATION_NAME;
         }
         _loc1_ = 0;
         while(_loc1_ < DETAIL_COUNT)
         {
            if(_loc1_ < _loc4_.length)
            {
               _loc2_ = this.FMC_List[_loc1_];
               _loc2_.visible = true;
               _loc5_ = _loc2_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_DATE];
               _loc6_ = _loc2_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_Name];
               _loc7_ = _loc2_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_Number];
               _loc8_ = _loc2_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_Result];
               _loc9_ = _loc2_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_FamilyIcon];
               _loc10_ = _loc2_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_FamilyBanner];
               if(_loc3_.ActivityType == TYPE_HURT)
               {
                  _loc9_.gotoAndStop(_loc4_[_loc1_].FamilyType + 1);
                  _loc10_.gotoAndStop(_loc4_[_loc1_].FamilyType + 1);
                  _loc8_.visible = false;
                  _loc7_.visible = true;
                  _loc5_.text = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_[_loc1_].ActivityDate) * 1000));
                  _loc6_.text = _loc4_[_loc1_].PlayerNick;
                  _loc7_.text = _loc4_[_loc1_].HurtScore == 0 ? "" : _loc4_[_loc1_].HurtScore.toString();
               }
               else if(_loc3_.ActivityType == TYPE_POINT)
               {
                  _loc9_.gotoAndStop(_loc4_[_loc1_].FamilyType + 1);
                  _loc10_.gotoAndStop(_loc4_[_loc1_].FamilyType + 1);
                  _loc8_.visible = false;
                  _loc7_.visible = true;
                  _loc5_.text = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_[_loc1_].ActivityDate) * 1000));
                  _loc6_.text = _loc4_[_loc1_].OrganzationName;
                  _loc7_.text = _loc4_[_loc1_].Point == 0 ? "" : _loc4_[_loc1_].Point.toString();
               }
               else
               {
                  _loc9_.gotoAndStop(_loc4_[_loc1_].FamilyType + 1);
                  _loc10_.gotoAndStop(_loc4_[_loc1_].FamilyType + 1);
                  _loc8_.gotoAndStop(_loc4_[_loc1_].FightResult + 1);
                  _loc8_.visible = true;
                  _loc7_.visible = false;
                  _loc5_.text = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_[_loc1_].ActivityDate) * 1000));
                  _loc6_.text = _loc4_[_loc1_].OrganzationName;
               }
            }
            else
            {
               this.FMC_List[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function set Index(param1:int) : void
      {
         this.FIndex = param1;
         this.UpdateList();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.Visible)
         {
         }
      }
   }
}

