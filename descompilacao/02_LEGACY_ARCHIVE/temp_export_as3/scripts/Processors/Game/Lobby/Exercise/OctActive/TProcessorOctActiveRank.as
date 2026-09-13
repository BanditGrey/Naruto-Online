package Processors.Game.Lobby.Exercise.OctActive
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.OctActive.TOctActive1;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorOctActiveRank extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 609;
      
      protected static const SIZE_Window_Height:uint = 498;
      
      protected static const RANK_LEVEL:int = 6;
      
      protected static const RANK_BOX_COUNT:int = 1;
      
      protected static const RANK_COUNT:int = 12;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FOctActive1:TOctActive1;
      
      protected var FIndex:int;
      
      protected var FUIRankBoxVect:Vector.<TUIBaseBox>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      public function TProcessorOctActiveRank(param1:TUIComponent)
      {
         super(param1);
         this.FUIRankBoxVect = new Vector.<TUIBaseBox>(RANK_LEVEL);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137105);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_OctActiveRank") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         _loc2_ = 0;
         while(_loc2_ < RANK_LEVEL)
         {
            _loc1_ = new TUIBaseBox(this,RANK_BOX_COUNT);
            _loc1_.Perform_UIDispatch(this.FMC_Scene["MC_Box" + _loc2_]);
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.TitleHintOnOver = this.MCTitleEffectOnOver;
            _loc1_.TitleHintOnOut = this.MCTitleEffectOnOut;
            this.FUIRankBoxVect[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FMC_ChangePage = this.FMC_Scene["MC_ChangePage"];
         this.FUI_Left_Btn = this.FMC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = RANK_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateText() : void
      {
         if(this.FOctActive1.CurMyRank <= 0)
         {
            this.FMC_Scene["TF_CurRank"].text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            this.FMC_Scene["TF_CurRank"].text = this.FOctActive1.CurMyRank.toString();
         }
         this.FMC_Scene["TF_Count"].text = this.FOctActive1.RankPoint.toString();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < RANK_LEVEL)
         {
            if(_loc1_ < this.FOctActive1.RankGiftList.length)
            {
               _loc4_ = this.FOctActive1.RankGiftList[_loc1_];
               _loc3_ = _loc4_.Inventories;
               this.FUIRankBoxVect[_loc1_].UpdateUI(_loc3_);
               this.FUIRankBoxVect[_loc1_].UpdateTitleEffect(_loc4_.TitleID);
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RANK_VALUE,_loc4_.Min,_loc4_.Max);
               this.FUIRankBoxVect[_loc1_].SetDescText(0,_loc5_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TextField = null;
         var _loc8_:TConsumeRankInfo = null;
         this.FUIPage.TotalQuantity = this.FOctActive1.RankPlayerList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * RANK_COUNT;
            _loc3_ = this.FMC_Scene["MC_Rank" + _loc1_];
            _loc4_ = _loc3_.TF_Name;
            _loc5_ = _loc3_.TF_Count;
            _loc6_ = _loc3_.TF_ServerID;
            _loc7_ = _loc3_.TF_Rank;
            if(_loc2_ < this.FOctActive1.RankPlayerList.length)
            {
               _loc8_ = this.FOctActive1.RankPlayerList[_loc2_];
               if(this.FCurPage == 0)
               {
                  this.FMC_Scene["TF_FirstNum"].visible = true;
                  this.FMC_Scene["TF_SecondNum"].visible = true;
                  this.FMC_Scene["TF_ThirdNum"].visible = true;
               }
               else
               {
                  this.FMC_Scene["TF_FirstNum"].visible = false;
                  this.FMC_Scene["TF_SecondNum"].visible = false;
                  this.FMC_Scene["TF_ThirdNum"].visible = false;
               }
               _loc4_.visible = true;
               if(_loc2_ < 3)
               {
                  _loc7_.visible = false;
               }
               else
               {
                  _loc7_.visible = true;
               }
               _loc5_.visible = true;
               _loc6_.visible = true;
               _loc4_.text = _loc8_.UserName;
               _loc5_.text = _loc8_.Score.toString();
               _loc6_.text = _loc8_.ServerName;
               _loc7_.text = String(_loc2_ + 1);
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
               _loc6_.visible = false;
               _loc7_.visible = false;
            }
            _loc1_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < RANK_LEVEL)
            {
               if(this.FUIRankBoxVect[_loc1_])
               {
                  this.FUIRankBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRank();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function MCTitleEffectOnOver(param1:uint) : void
      {
         if(this.FTitleHintOnOver != null)
         {
            this.FTitleHintOnOver(param1);
         }
      }
      
      protected function MCTitleEffectOnOut() : void
      {
         if(this.FTitleHintOnOut != null)
         {
            this.FTitleHintOnOut();
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function get CurPage() : int
      {
         return this.FCurPage;
      }
      
      public function set CurPage(param1:int) : void
      {
         this.FCurPage = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FOctActive1 = SLogicsCore.OctActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TOctActive1;
         this.UpdateText();
         this.UpdateBox();
         this.UpdateRank();
      }
   }
}

