package Processors.Game.Lobby.Exercise.FortuneCat
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.FortuneCat.TFortuneCat;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerFortuneCat;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_SEVENTHEVENING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorFortuneCat extends TProcessorBaseActivity
   {
      
      public static const LOG_COUNT:int = 5;
      
      public static const TYPE_COST_GOLD:int = 1;
      
      public static const TYPE_GET_BOX:int = 2;
      
      public static const LABA_COUNT:int = 12;
      
      protected static const LABA_ItemStamp:int = 64;
      
      protected static const MAX_LABACOUNT:int = 10;
      
      protected var FFortuneCat:TFortuneCat;
      
      protected var FBeClicked:Boolean;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUnstreamizerFortuneCat:TUnstreamizerFortuneCat;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBuyBoxDate:Object;
      
      protected var FLabaInitY:int;
      
      protected var FLabaIndex0:int;
      
      protected var FLabaIndex1:int;
      
      protected var FLabaIndex2:int;
      
      protected var FLabaIndex3:int;
      
      protected var FLabaIndex4:int;
      
      protected var FLabaIndex5:int;
      
      protected var FUIItems:Vector.<MovieClip>;
      
      protected var FLabaList:Vector.<MovieClip>;
      
      protected var FGold:int;
      
      protected var FIsOpen:Boolean;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TProcessorFortuneCat(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FFortuneCat = SLogicsCore.FortuneCat;
         this.FUnstreamizerFortuneCat = new TUnstreamizerFortuneCat();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBuyBoxDate = new Object();
         this.FUIItems = new Vector.<MovieClip>(LABA_COUNT);
         this.FLabaList = new Vector.<MovieClip>(LABA_COUNT / 2);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         super.ResourcesPerform_UIDispatch();
         TGameUtil.setButtonMode(FMC_Scene.MC_Click,true);
         FMC_Scene.MC_Click.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
         _loc1_ = 0;
         while(_loc1_ < LABA_COUNT)
         {
            _loc4_ = TUtilityReflection.CreateDisplayObjectInstance("MC_FortuneCatItem") as MovieClip;
            this.FUIItems[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LABA_COUNT / 2)
         {
            this.FLabaList[_loc1_] = FMC_Scene.MC_Laba["MC_LabaItem" + _loc1_];
            this.FLabaList[_loc1_].addChild(this.FUIItems[_loc1_ * 2]);
            this.FLabaList[_loc1_].addChild(this.FUIItems[_loc1_ * 2 + 1]);
            _loc1_++;
         }
         this.FLabaInitY = this.FLabaList[0].y;
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && Boolean(FMC_Scene.visible) && this.FFortuneCat.DescList.length > 0)
            {
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FFortuneCat.EndTime - STimingCore.GetServerTick());
               if(this.FFortuneCat.GameStatus != TFortuneCat.GAME_STATUS_END && this.FFortuneCat.EndTime <= STimingCore.GetServerTick())
               {
                  this.FFortuneCat.GameStatus = TFortuneCat.GAME_STATUS_END;
                  this.UpdateBtn();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateBtn();
         this.UpdateLog();
         this.UpdateBox();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FFortuneCat.ConsumeGift.length;
         this.FUIPage.Update();
         _loc2_ = this.FCurPage;
         _loc4_ = FMC_Scene.MC_Gift;
         _loc4_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
         if(this.FFortuneCat.ConsumeGift.length == 0)
         {
            FMC_Scene.MC_Gift.visible = false;
            FMC_Scene.Btn_Right.visible = false;
            FMC_Scene.Btn_Left.visible = false;
         }
         else
         {
            _loc5_ = this.FFortuneCat.ConsumeGift[_loc2_];
            _loc4_.TF_Desc.text = TUtilityString.Format(this.FFortuneCat.DescListNew[5],_loc5_.Price);
            if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc4_.MC_Got.visible = false;
               _loc4_.MC_Click.visible = false;
            }
            else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc4_.MC_Got.visible = false;
               _loc4_.MC_Click.visible = true;
            }
            else
            {
               _loc4_.MC_Got.visible = true;
               _loc4_.MC_Click.visible = false;
            }
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FFortuneCat.GameStatus == TFortuneCat.GAME_STATUS_NOT_BEGIN)
         {
            FMC_Scene.MC_Click.visible = false;
            FMC_Scene.MC_Tip.visible = true;
            FMC_Scene.MC_End.visible = false;
            if(this.FFortuneCat.RechargeGold >= this.FFortuneCat.NeedGold)
            {
               FMC_Scene.MC_Tip.TF_Desc0.htmlText = TUtilityString.Format(this.FFortuneCat.DescListNew[7],this.FFortuneCat.NeedGold);
            }
            else
            {
               FMC_Scene.MC_Tip.TF_Desc0.htmlText = TUtilityString.Format(this.FFortuneCat.DescListNew[8],this.FFortuneCat.NeedGold);
            }
            if(SLogicsCore.Character.VipLevel >= this.FFortuneCat.NeedVip)
            {
               FMC_Scene.MC_Tip.TF_Desc1.htmlText = TUtilityString.Format(this.FFortuneCat.DescListNew[9],this.FFortuneCat.NeedVip);
            }
            else
            {
               FMC_Scene.MC_Tip.TF_Desc1.htmlText = TUtilityString.Format(this.FFortuneCat.DescListNew[10],SLogicsCore.Character.VipLevel,this.FFortuneCat.NeedVip);
            }
         }
         else if(this.FFortuneCat.GameStatus == TFortuneCat.GAME_STATUS_NORMAL)
         {
            FMC_Scene.MC_Click.visible = true;
            FMC_Scene.MC_Tip.visible = false;
            FMC_Scene.MC_End.visible = false;
         }
         else
         {
            FMC_Scene.MC_Click.visible = false;
            FMC_Scene.MC_Tip.visible = false;
            FMC_Scene.MC_End.visible = true;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < LOG_COUNT)
         {
            if(_loc4_ < this.FFortuneCat.AllLogs.length)
            {
               FMC_Scene["TF_Log" + _loc4_].visible = true;
               _loc3_ = this.FFortuneCat.AllLogs[_loc4_];
               _loc1_ = this.FFortuneCat.DescListNew[1];
               _loc1_ = _loc1_.split("&lt;").join("<");
               _loc1_ = _loc1_.split("&gt;").join(">");
               _loc1_ = _loc1_.split("%who%").join(_loc3_.Desc1);
               _loc1_ += STRING_SEVENTHEVENING.FORMAT_News_Item[5];
               _loc1_ = _loc1_.split("%what%").join(STRING_BASEACTIVITY.FORMAT_PAY_LIMIT);
               _loc1_ = TUtilityString.Format(_loc1_,_loc3_.Count);
               FMC_Scene["TF_Log" + _loc4_].htmlText = _loc1_;
            }
            else
            {
               FMC_Scene["TF_Log" + _loc4_].visible = false;
            }
            _loc4_++;
         }
      }
      
      protected function UpdateLaBa() : void
      {
         var _loc1_:uint = 0;
         this.FLabaList[0].y = this.FLabaInitY;
         this.FLabaList[1].y = this.FLabaInitY;
         this.FLabaList[2].y = this.FLabaInitY;
         this.FLabaList[3].y = this.FLabaInitY;
         this.FLabaList[4].y = this.FLabaInitY;
         this.FLabaList[5].y = this.FLabaInitY;
         _loc1_ = 0;
         while(_loc1_ < LABA_COUNT)
         {
            if(_loc1_ % 2 == 0)
            {
               this.FUIItems[_loc1_].y = 0;
               this.FUIItems[_loc1_].TF_Num.text = "0";
            }
            else
            {
               this.FUIItems[_loc1_].y = LABA_ItemStamp;
               this.FUIItems[_loc1_].TF_Num.text = "1";
            }
            _loc1_++;
         }
         this.FLabaIndex0 = 1;
         this.FLabaIndex1 = 1;
         this.FLabaIndex2 = 1;
         this.FLabaIndex3 = 1;
         this.FLabaIndex4 = 1;
         this.FLabaIndex5 = 1;
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:Array = null;
         var _loc2_:TCharacter = null;
         FMC_Scene.TF_Desc.text = this.FFortuneCat.DescListNew[0];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FFortuneCat.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FFortuneCat.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Count.text = this.FFortuneCat.MaxCount - this.FFortuneCat.CurCount + 1;
         if(this.FFortuneCat.CurCount <= this.FFortuneCat.MaxCount)
         {
            FMC_Scene.TF_Cost.text = TUtilityString.Format(this.FFortuneCat.DescListNew[3],this.FFortuneCat.GoldList[this.FFortuneCat.CurCount - 1]);
            _loc1_ = Json.decode(this.FFortuneCat.DescListNew[4]) as Array;
            FMC_Scene.TF_Get.text = _loc1_[this.FFortuneCat.CurCount - 1];
         }
         else
         {
            FMC_Scene.TF_Cost.text = "";
            FMC_Scene.TF_Get.text = "";
         }
         _loc2_ = SLogicsCore.Character;
         FMC_Scene.TF_Gold.text = _loc2_.CreditGold.toString();
         FMC_Scene.TF_RechargeGold.text = this.FFortuneCat.RechargeGold.toString();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FFortuneCat) && this.FCurPage < this.FFortuneCat.ConsumeGift.length)
         {
            if(this.FFortuneCat.ConsumeGift[this.FCurPage].Status == TBaseActivity.STATUS_CANGET)
            {
               this.ProcessorOnGetBoxUp(TYPE_GET_BOX,this.FCurPage + 1);
            }
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FFortuneCat.GameStatus != TFortuneCat.GAME_STATUS_NORMAL || this.FFortuneCat.GoldList.length <= 0)
         {
            return;
         }
         this.FBuyBoxDate.BoxType = TYPE_COST_GOLD;
         this.FBuyBoxDate.BoxIndex = 1;
         this.FBuyBoxDate.Cost = this.FFortuneCat.GoldList[this.FFortuneCat.CurCount - 1];
         this.FBuyBoxDate.CostType = TBaseActivity.SWEET_TYPE_GOLD;
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FBuyBoxDate.Cost);
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         _loc2_ = this.FFortuneCat.ConsumeGift[this.FCurPage].Inventories;
         ProcessorOnNewBoxOver(_loc2_);
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
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerFortuneCat.Unstreamize(_loc2_,this.FFortuneCat,null);
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FFortuneCat.GameStatus == TFortuneCat.GAME_STATUS_NOT_BEGIN)
         {
            this.FFortuneCat.RechargeGold = _loc2_.readUnsignedInt();
            this.FFortuneCat.GameStatus = _loc2_.readInt();
            _loc4_ = 0;
            while(_loc4_ < this.FFortuneCat.ConsumeGift.length)
            {
               this.FFortuneCat.ConsumeGift[_loc4_].Status = _loc2_.readInt();
               _loc4_++;
            }
            if(Boolean(FMC_Scene) && Boolean(FMC_Scene.visible) && this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
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
            case TYPE_COST_GOLD:
               this.FGold = _loc2_.readUnsignedInt();
               this.FFortuneCat.GameStatus = _loc2_.readInt();
               this.FFortuneCat.NeedGold = _loc2_.readUnsignedInt();
               this.FFortuneCat.NeedVip = _loc2_.readUnsignedInt();
               ++this.FFortuneCat.CurCount;
               this.PlayLaBaMovie();
               break;
            case TYPE_GET_BOX:
               _loc6_ = _loc2_.readUnsignedInt() - 1;
               this.FFortuneCat.ConsumeGift[_loc6_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FFortuneCat.ConsumeGift[_loc6_].Inventories.Count)
               {
                  _loc9_ = this.FFortuneCat.ConsumeGift[_loc6_].Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FFortuneCat.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayLaBaMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.UpdateLaBa();
         _loc1_ = this.FGold / 100000;
         _loc2_ = this.FGold / 10000 % 10;
         _loc3_ = this.FGold / 1000 % 10;
         _loc4_ = this.FGold / 100 % 10;
         _loc5_ = this.FGold / 10 % 10;
         _loc6_ = this.FGold % 10;
         TweenUtil.to(this.FLabaList[0],3000,{
            "y":this.FLabaList[0].y - LABA_ItemStamp * (MAX_LABACOUNT + _loc1_),
            "onUpdate":this.CheckOutArea0,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList[1],3500,{
            "y":this.FLabaList[1].y - LABA_ItemStamp * (MAX_LABACOUNT + _loc2_),
            "onUpdate":this.CheckOutArea1,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList[2],4000,{
            "y":this.FLabaList[2].y - LABA_ItemStamp * (MAX_LABACOUNT + _loc3_),
            "onUpdate":this.CheckOutArea2,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList[3],4500,{
            "y":this.FLabaList[3].y - LABA_ItemStamp * (MAX_LABACOUNT + _loc4_),
            "onUpdate":this.CheckOutArea3,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList[4],5000,{
            "y":this.FLabaList[4].y - LABA_ItemStamp * (MAX_LABACOUNT + _loc5_),
            "onUpdate":this.CheckOutArea4,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList[5],5000,{
            "y":this.FLabaList[5].y - LABA_ItemStamp * (MAX_LABACOUNT + _loc6_),
            "onUpdate":this.CheckOutArea5,
            "onComplete":this.LaBaMovieEnd,
            "ease":Expo.easeOut
         });
      }
      
      public function CheckOutArea0() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList[0].y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex0 - 1)
         {
            this.FUIItems[0 + (this.FLabaIndex0 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[0 + (this.FLabaIndex0 + 1) % 2];
            ++this.FLabaIndex0;
            _loc1_.TF_Num.text = this.FLabaIndex0 % 10;
         }
      }
      
      public function CheckOutArea1() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList[1].y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex1 - 1)
         {
            this.FUIItems[2 + (this.FLabaIndex1 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[2 + (this.FLabaIndex1 + 1) % 2];
            ++this.FLabaIndex1;
            _loc1_.TF_Num.text = this.FLabaIndex1 % 10;
         }
      }
      
      public function CheckOutArea2() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList[2].y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex2 - 1)
         {
            this.FUIItems[4 + (this.FLabaIndex2 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[4 + (this.FLabaIndex2 + 1) % 2];
            ++this.FLabaIndex2;
            _loc1_.TF_Num.text = this.FLabaIndex2 % 10;
         }
      }
      
      public function CheckOutArea3() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList[3].y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex3 - 1)
         {
            this.FUIItems[6 + (this.FLabaIndex3 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[6 + (this.FLabaIndex3 + 1) % 2];
            ++this.FLabaIndex3;
            _loc1_.TF_Num.text = this.FLabaIndex3 % 10;
         }
      }
      
      public function CheckOutArea4() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList[4].y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex4 - 1)
         {
            this.FUIItems[8 + (this.FLabaIndex4 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[8 + (this.FLabaIndex4 + 1) % 2];
            ++this.FLabaIndex4;
            _loc1_.TF_Num.text = this.FLabaIndex4 % 10;
         }
      }
      
      public function CheckOutArea5() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList[5].y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex5 - 1)
         {
            this.FUIItems[10 + (this.FLabaIndex5 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[10 + (this.FLabaIndex5 + 1) % 2];
            ++this.FLabaIndex5;
            _loc1_.TF_Num.text = this.FLabaIndex5 % 10;
         }
      }
      
      public function LaBaMovieEnd() : void
      {
         var _loc1_:String = null;
         _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc1_ += TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_PAY_LIMIT,this.FGold);
         ProcessorEffectText(_loc1_);
         if(this.FFortuneCat.CurCount > this.FFortuneCat.MaxCount)
         {
            this.FFortuneCat.GameStatus = TFortuneCat.GAME_STATUS_END;
         }
         this.UpdateUI();
         TGameUtil.setButtonMode(FMC_Scene.MC_Click,true);
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,2,3,4,5]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         _loc3_.writeShort(5);
         TUtilityString.FlushUTF(_loc3_,"活动说明1");
         TUtilityString.FlushUTF(_loc3_,"全服Log %0购买了%1 ");
         TUtilityString.FlushUTF(_loc3_,"你还有%0次召唤机会");
         TUtilityString.FlushUTF(_loc3_,"招财猫还剩X天X小时X分X秒即将离开");
         TUtilityString.FlushUTF(_loc3_,"本次祈福需要花费%0金币");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"<font color=\'#66FF66\'>累计充值%0金币激活拉霸,已激活</font>");
         TUtilityString.FlushUTF(_loc3_,"<font color=\'#FF0000\'>累计充值%0金币激活拉霸,未激活</font>");
         TUtilityString.FlushUTF(_loc3_,"<font color=\'#66FF66\'>需要VIP%0激活拉霸,已激活</font>");
         TUtilityString.FlushUTF(_loc3_,"<font color=\'#FF0000\'>需要VIP%0/%1激活拉霸,未激活</font>");
         _loc3_.writeInt(1);
         _loc3_.writeInt(1);
         _loc3_.writeInt(5);
         _loc3_.writeShort(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeShort(0);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

