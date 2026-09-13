package Processors.Game.Lobby.Exercise.WishTree
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.WishTree.TWishTree;
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
   
   public class TProcessorWishTreeRank extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 515;
      
      protected static const SIZE_Window_Height:uint = 458;
      
      protected static const KILL_COUNT:int = 3;
      
      protected static const KILL_BOX_COUNT:int = 1;
      
      protected static const RANK_COUNT:int = 6;
      
      protected static const RANK_BOX_COUNT:int = 1;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FWishTree:TWishTree;
      
      protected var FIndex:int;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FUIRankBoxVect:Vector.<TUIBaseBox>;
      
      protected var FCost:int;
      
      protected var FBeClicked:Boolean;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FRankList:Vector.<Sprite>;
      
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
      
      public function TProcessorWishTreeRank(param1:TUIComponent)
      {
         super(param1);
         this.FWishTree = SLogicsCore.WishTree;
         this.FUIBoxVect = new Vector.<TUIBaseBox>(KILL_COUNT);
         this.FUIRankBoxVect = new Vector.<TUIBaseBox>(RANK_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2264924160);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2,0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_WishTreeRank") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         _loc2_ = 0;
         while(_loc2_ < KILL_COUNT)
         {
            _loc1_ = new TUIBaseBox(this,KILL_BOX_COUNT);
            _loc1_.Perform_UIDispatch(this.FMC_Scene["MC_Item" + _loc2_]);
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.OnGetBox = this.ProcessorOnBuyUp;
            this.FUIBoxVect[_loc2_] = _loc1_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < RANK_COUNT)
         {
            _loc1_ = new TUIBaseBox(this,RANK_BOX_COUNT);
            _loc1_.Perform_UIDispatch(this.FMC_Scene["MC_Rank" + _loc2_]);
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.TitleHintOnOver = this.MCTitleEffectOnOver;
            _loc1_.TitleHintOnOut = this.MCTitleEffectOnOut;
            this.FUIRankBoxVect[_loc2_] = _loc1_;
            _loc2_++;
         }
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
         if(this.FWishTree.CurRank == 0)
         {
            this.FMC_Scene["TF_CurRank"].text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            this.FMC_Scene["TF_CurRank"].text = this.FWishTree.CurRank.toString();
         }
         this.FMC_Scene["TF_KillCount"].text = this.FWishTree.Point.toString();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TBaseBox = null;
         var _loc7_:String = null;
         _loc1_ = 0;
         while(_loc1_ < KILL_COUNT)
         {
            _loc6_ = this.FWishTree.KillBox[_loc1_];
            _loc5_ = _loc6_.Inventories;
            this.FUIBoxVect[_loc1_].UpdateUI(_loc5_);
            this.FUIBoxVect[_loc1_].SetNameText(_loc5_.GetInventoryByIndex(0).Name);
            _loc7_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_WISH_STR_0,_loc6_.Price);
            this.FUIBoxVect[_loc1_].SetDescText(0,_loc7_);
            if(_loc6_.Status == TBaseActivity.STATUS_GETED)
            {
               this.FUIBoxVect[_loc1_].IsBoxGot(true);
            }
            else if(_loc6_.Status == TBaseActivity.STATUS_CANGET)
            {
               this.FUIBoxVect[_loc1_].SetBtnMode(true);
               this.FUIBoxVect[_loc1_].IsBoxGot(false);
            }
            else
            {
               this.FUIBoxVect[_loc1_].SetBtnMode(false);
               this.FUIBoxVect[_loc1_].IsBoxGot(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TBaseBox = null;
         var _loc7_:String = null;
         var _loc8_:MovieClip = null;
         var _loc9_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc9_ = _loc1_ + this.FCurPage * RANK_COUNT;
            _loc8_ = this.FMC_Scene["MC_Rank" + _loc1_];
            if(_loc9_ < this.FWishTree.KillRank.length)
            {
               _loc8_.visible = true;
               _loc6_ = this.FWishTree.KillRank[_loc9_];
               _loc5_ = _loc6_.Inventories;
               this.FUIRankBoxVect[_loc1_].UpdateUI(_loc5_);
               this.FUIRankBoxVect[_loc1_].UpdateTitleEffect(_loc6_.TitleID);
               _loc7_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RANK_VALUE,_loc6_.Min,_loc6_.Max);
               this.FUIRankBoxVect[_loc1_].SetDescText(0,_loc7_);
            }
            else
            {
               _loc8_.visible = false;
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
            while(_loc1_ < KILL_COUNT)
            {
               if(this.FUIBoxVect[_loc1_])
               {
                  this.FUIBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < RANK_COUNT)
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
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            this.FBeClicked = true;
            _loc3_ = int(param1.currentTarget.parent.name.slice(7));
            this.FOnGetBox(_loc3_);
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
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get BeClicked() : Boolean
      {
         return this.FBeClicked;
      }
      
      public function set BeClicked(param1:Boolean) : void
      {
         this.FBeClicked = param1;
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
      
      public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateRank();
      }
   }
}

