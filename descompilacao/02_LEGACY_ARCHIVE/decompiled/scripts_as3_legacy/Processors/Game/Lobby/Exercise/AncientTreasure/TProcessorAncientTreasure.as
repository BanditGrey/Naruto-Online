package Processors.Game.Lobby.Exercise.AncientTreasure
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.AncientTreasure.TAncientTreasure;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerAncientTreasure;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorAncientTreasure extends TProcessorBaseActivity
   {
      
      public static const ROAD_COUNT:int = 25;
      
      public static const MOVIE_ROTATION_DISK:int = 1;
      
      public static const MOVIE_PLAYER_MOVE:int = 2;
      
      public static const ROTATION_COUNT:int = 2;
      
      public static const RANDOM_COUNT:int = 2;
      
      public static const EVERY_DEGREE:Vector.<int> = Vector.<int>([350,320,240,50,125,165]);
      
      protected static const MOVIE_TIMES:int = 10;
      
      public static const ACTIVITY_1_SIGN:int = 1;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FAncientTreasure:TAncientTreasure;
      
      protected var FUnstreamizerAncientTreasure:TUnstreamizerAncientTreasure;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FRoadList:Vector.<TUIBaseBox>;
      
      protected var FNextBox:TUIBaseBox;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMovieType:int;
      
      protected var FStep:int;
      
      protected var FFrameCount:int;
      
      protected var FMoveIndex:int;
      
      protected var FEndIndex:int;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      public function TProcessorAncientTreasure(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FAncientTreasure = SLogicsCore.AncientTreasure;
         this.FUnstreamizerAncientTreasure = new TUnstreamizerAncientTreasure();
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FRoadList = new Vector.<TUIBaseBox>(ROAD_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         this.FNextBox = new TUIBaseBox(this,1);
         this.FNextBox.Perform_UIDispatch(FMC_Scene.MC_NextBox);
         this.FNextBox.OnOverlay = UIComponentsHintOnOver;
         this.FNextBox.OnOut = UIComponentsHintOnOut;
         _loc1_ = 0;
         while(_loc1_ < ROAD_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene.MC_Road["MC_Slot" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.SetMCIsVisible("MC_Effect",false);
            _loc5_.SetMCIsMouseEnabled("MC_Effect",false);
            this.FRoadList[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_PageRight;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = ROAD_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         FMC_Scene.BTN_Sign.addEventListener(MouseEvent.CLICK,this.ProcessorOnSignUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         FMC_Scene.MC_Road.MC_LastBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLastBoxOver);
         FMC_Scene.MC_Road.MC_LastBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnLastBoxOut);
         FMC_Scene.MC_LastBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLastBoxOver);
         FMC_Scene.MC_LastBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnLastBoxOut);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,ProcessorOnRechargeUp);
         FMC_Scene.MC_SurpriseBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSurpriseBoxOver);
         FMC_Scene.MC_SurpriseBox.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FAncientTreasure)
            {
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FAncientTreasure.EndTime - STimingCore.GetServerTick());
               _loc1_ = 0;
               while(_loc1_ < ROAD_COUNT)
               {
                  if(this.FRoadList[_loc1_])
                  {
                     this.FRoadList[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
               if(this.FNextBox)
               {
                  this.FNextBox.LogicsPerform();
               }
            }
            if(this.FIsPlaying)
            {
               if(this.FMovieType == MOVIE_PLAYER_MOVE)
               {
                  this.PlayMovie(MOVIE_PLAYER_MOVE);
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdatePage();
         this.UpdateWindow();
      }
      
      public function UpdatePage() : void
      {
         if(this.FAncientTreasure.CurIndex >= ROAD_COUNT)
         {
            this.FUIPage.PageIndex = 1;
            this.ProcessorPageOnChange(null,1);
         }
         else
         {
            this.FUIPage.PageIndex = 0;
            this.ProcessorPageOnChange(null,0);
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateRoad();
         this.UpdateBtn();
         this.UpdateText();
      }
      
      protected function UpdateRoad() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         var _loc5_:TUIBaseBox = null;
         this.FUIPage.TotalQuantity = TAncientTreasure.MAX_COUNT;
         this.FUIPage.Update();
         if(this.FAncientTreasure.CurIndex == -1 && this.FCurPage == 0)
         {
            FMC_Scene.MC_Head.visible = true;
            FMC_Scene.MC_HeadEnd.visible = false;
            FMC_Scene.MC_Road.MC_LastBox.MC_Got.visible = false;
         }
         else if(this.FAncientTreasure.CurIndex == TAncientTreasure.MAX_COUNT - 1 && this.FCurPage == 1)
         {
            FMC_Scene.MC_Head.visible = false;
            FMC_Scene.MC_HeadEnd.visible = true;
            FMC_Scene.MC_Road.MC_LastBox.MC_Got.visible = true;
         }
         else
         {
            FMC_Scene.MC_Head.visible = false;
            FMC_Scene.MC_HeadEnd.visible = false;
            FMC_Scene.MC_Road.MC_LastBox.MC_Got.visible = false;
         }
         if(this.FAncientTreasure.CurIndex == TAncientTreasure.MAX_COUNT - 1)
         {
            FMC_Scene.MC_LastBox.MC_Got.visible = true;
         }
         else
         {
            FMC_Scene.MC_LastBox.MC_Got.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < ROAD_COUNT)
         {
            _loc5_ = this.FRoadList[_loc1_];
            _loc3_ = ROAD_COUNT * this.FCurPage + _loc1_;
            _loc4_ = this.FAncientTreasure.BoxList[_loc3_];
            _loc5_.UpdateUI(_loc4_.Inventories);
            if(Boolean(_loc4_) && _loc4_.Type == 2)
            {
               _loc5_.SetMCIsVisible("MC_Fire",true);
            }
            else
            {
               _loc5_.SetMCIsVisible("MC_Fire",false);
            }
            if(_loc3_ == this.FAncientTreasure.CurIndex)
            {
               _loc5_.SetMCIsVisible("MC_Effect",true);
            }
            else
            {
               _loc5_.SetMCIsVisible("MC_Effect",false);
            }
            _loc1_++;
         }
         if(this.FCurPage == 0)
         {
            FMC_Scene.MC_Start.visible = true;
            FMC_Scene.MC_End.visible = false;
            this.FRoadList[24].SetVisible(true);
            FMC_Scene.MC_Road.MC_LastBox.visible = false;
         }
         else
         {
            FMC_Scene.MC_Start.visible = false;
            FMC_Scene.MC_End.visible = true;
            this.FRoadList[24].SetVisible(false);
            FMC_Scene.MC_Road.MC_LastBox.visible = true;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FAncientTreasure.SignStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
            FMC_Scene.MC_Sign.gotoAndStop(1);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,false);
            FMC_Scene.MC_Sign.gotoAndStop(2);
         }
         if(this.FAncientTreasure.SurpriseStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_SurpriseBox.gotoAndStop(2);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_SurpriseBox.gotoAndStop(1);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FAncientTreasure.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FAncientTreasure.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FAncientTreasure.DescListNew[1];
         _loc1_ = this.FAncientTreasure.GetNextBoxIndex();
         if(_loc1_ != -1)
         {
            _loc2_ = this.FAncientTreasure.BoxList[_loc1_].Inventories;
            this.FNextBox.UpdateUI(_loc2_);
            FMC_Scene.TF_NextBox.text = TUtilityString.Format(this.FAncientTreasure.DescListNew[2],_loc1_ - this.FAncientTreasure.CurIndex);
         }
         FMC_Scene.TF_LastBox.text = TUtilityString.Format(this.FAncientTreasure.DescListNew[2],this.FAncientTreasure.BoxList.length - 1 - this.FAncientTreasure.CurIndex);
         FMC_Scene.TF_SurpriseDesc.text = this.FAncientTreasure.DescListNew[3];
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnSignUp(param1:MouseEvent) : void
      {
         if(this.FAncientTreasure.SignStatus == TBaseActivity.STATUS_CANGET && !this.FIsPlaying)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_SIGN);
         }
      }
      
      protected function ProcessorOnLastBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(this.FAncientTreasure) && this.FAncientTreasure.BoxList.length > 0)
         {
            _loc3_ = this.FAncientTreasure.BoxList.length - 1;
            _loc2_ = this.FAncientTreasure.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnLastBoxOut(param1:MouseEvent) : void
      {
         if(Boolean(this.FAncientTreasure) && this.FAncientTreasure.BoxList.length > 0)
         {
            UIComponentsHintOnOut(this,null);
         }
      }
      
      protected function ProcessorOnSurpriseBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FAncientTreasure) && this.FAncientTreasure.DescList.length >= 5)
         {
            ProcessorOnShowHtmlText(this.FAncientTreasure.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FAncientTreasure;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateWindow();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerAncientTreasure.Unstreamize(_loc2_,this.FAncientTreasure,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FAncientTreasure)
         {
            this.FAncientTreasure.SurpriseStatus = _loc2_.readInt();
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FAncientTreasure,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_1_SIGN:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FAncientTreasure.GameStatus = _loc2_.readInt();
               this.FAncientTreasure.SignStatus = TBaseActivity.STATUS_GETED;
               this.SetMovieParam(_loc5_);
               this.PlayMovie(1);
               ProcessorCheckEffect(FActivityID,this.FAncientTreasure.CheckStatus());
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_ROTATION_DISK)
         {
            _loc6_ = EVERY_DEGREE[this.FStep - 1] + (ROTATION_COUNT + int(Math.random() * RANDOM_COUNT)) * 360;
            TweenUtil.to(FMC_Scene.MC_Round,3000,{
               "rotation":_loc6_,
               "ease":Expo.easeOut,
               "onComplete":this.MovieEnd
            });
         }
         else if(this.FMovieType == MOVIE_PLAYER_MOVE)
         {
            ++this.FFrameCount;
            if(this.FFrameCount < MOVIE_TIMES)
            {
               return;
            }
            this.FFrameCount = 0;
            _loc3_ = 0;
            while(_loc3_ < ROAD_COUNT)
            {
               this.FRoadList[_loc3_].SetMCIsVisible("MC_Effect",false);
               _loc3_++;
            }
            ++this.FMoveIndex;
            if(this.FMoveIndex >= ROAD_COUNT && this.FCurPage != 1)
            {
               this.FUIPage.PageIndex = 1;
               this.ProcessorPageOnChange(null,1);
            }
            _loc7_ = this.FMoveIndex % ROAD_COUNT;
            this.FRoadList[_loc7_].SetMCIsVisible("MC_Effect",true);
            if(this.FMoveIndex == this.FEndIndex)
            {
               this.MovieEnd();
            }
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         if(this.FMovieType == MOVIE_ROTATION_DISK)
         {
            this.FMoveIndex = this.FAncientTreasure.CurIndex;
            this.FEndIndex = Math.min(TAncientTreasure.MAX_COUNT - 1,this.FAncientTreasure.CurIndex + this.FStep);
            if(this.FMoveIndex < ROAD_COUNT)
            {
               if(this.FCurPage != 0)
               {
                  this.FUIPage.PageIndex = 0;
                  this.ProcessorPageOnChange(null,0);
               }
            }
            else if(this.FMoveIndex >= ROAD_COUNT)
            {
               if(this.FCurPage != 1)
               {
                  this.FUIPage.PageIndex = 1;
                  this.ProcessorPageOnChange(null,1);
               }
            }
            this.PlayMovie(MOVIE_PLAYER_MOVE);
         }
         else if(this.FMovieType == MOVIE_PLAYER_MOVE)
         {
            this.FIsPlaying = false;
            this.FAncientTreasure.CurIndex = this.FEndIndex;
            if(Boolean(this.FAncientTreasure.BoxList[this.FEndIndex]) && this.FAncientTreasure.BoxList[this.FEndIndex].Type > 0)
            {
               _loc2_ = this.FAncientTreasure.BoxList[this.FEndIndex].Inventories.GetInventoryByIndex(0);
               _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc1_ += _loc2_.Name + "*" + _loc2_.Quantity + "\n";
               ProcessorEffectText(_loc1_);
            }
            this.UpdateUI();
         }
      }
      
      public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FStep = param1;
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(11);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"距离下个矿山还差%0金币");
         TUtilityString.FlushUTF(_loc3_,"连续返还10天");
         TUtilityString.FlushUTF(_loc3_,"累计%0金币");
         TUtilityString.FlushUTF(_loc3_,"总返还%0%1");
         TUtilityString.FlushUTF(_loc3_,"每日返还%0%1");
         TUtilityString.FlushUTF(_loc3_,"价值9999金币");
         TUtilityString.FlushUTF(_loc3_,"预留1");
         TUtilityString.FlushUTF(_loc3_,"预留2");
         TUtilityString.FlushUTF(_loc3_,"预留3");
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(1);
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(_loc1_ % 9 + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

