package Processors.Game.Lobby.Exercise.NinjaMeeting
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
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Exercise.NewYear.TNewYear;
   import Logics.Exercise.NinjaMeet.TNinjaMeeting;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNinjaMeeting;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.NationalDay.TOverlayerSimpleNinjia;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjaMeeting extends TProcessorBaseActivity
   {
      
      public static const HERO_COUNT:int = 7;
      
      public static const BOX_COUNT:int = 6;
      
      public static const HERO_BODY_COUNT:int = 3;
      
      public static const HERO_FACE_COUNT:int = 4;
      
      public static const HERO_TYPE_ALL:int = 1;
      
      public static const HERO_TYPE_HEAD:int = 0;
      
      public static const TYPE_EXCHANGE_HERO:int = 1;
      
      public static const TYPE_EXCHANGE_ITEM:int = 2;
      
      protected static const COLOR_ContextOddsAward:uint = 4294967295;
      
      protected static const COLOR_ContextRobbed:uint = 4284900966;
      
      protected static const QUALITYCOLOR_None:uint = 4294967295;
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      protected static const QUALITYCOLOR_Yellow:uint = 4294967040;
      
      protected static const QUALITYCOLOR_Red:uint = 4294836224;
      
      protected static const QUALITYCOLOR_Orange:uint = 4294901888;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FHeroActive:Vector.<TActive>;
      
      protected var FHeroRoleModel:Vector.<TRoleModel>;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FNinjaMeeting:TNinjaMeeting;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerNinjaMeeting:TUnstreamizerNinjaMeeting;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FCost:int;
      
      protected var FCostVouchers:int;
      
      protected var FCostGold:int;
      
      protected var FOverlayerSimpleNinjia:TOverlayerSimpleNinjia;
      
      protected var FRoleModel:TBins;
      
      protected var FTextFormat:TextFormat;
      
      protected var FConfirmType:int;
      
      protected var FTemplateIDList:Vector.<uint>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TProcessorNinjaMeeting(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNinjaMeeting = SLogicsCore.NinjaMeeting;
         this.FUnstreamizerNinjaMeeting = new TUnstreamizerNinjaMeeting();
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
         this.FHeroActive = new Vector.<TActive>(HERO_COUNT);
         this.FHeroRoleModel = new Vector.<TRoleModel>(HERO_COUNT);
         this.FUIBoxVect = new Vector.<TUIBaseBox>(BOX_COUNT);
         this.FTemplateIDList = new Vector.<uint>(HERO_COUNT);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FOverlayerSimpleNinjia = new TOverlayerSimpleNinjia(this.Parent);
         this.FOverlayerSimpleNinjia.Visible = false;
         this.FTextFormat = new TextFormat();
         this.FUIPage = new TUIPage(this);
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Bitmap = null;
         var _loc6_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Hero" + _loc1_];
            _loc5_ = new Bitmap();
            _loc4_.MC_Hero["heroHead"] = _loc5_;
            _loc4_.MC_Hero.addChild(_loc5_);
            _loc4_.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
            _loc4_.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            TGameUtil.setButtonMode(_loc4_.BTN_Recruit,true);
            _loc4_.BTN_Recruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
            TGameUtil.setButtonMode(_loc4_.BTN_ShowDesc,true);
            _loc4_.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
            this.FHeroList[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc6_ = new TUIBaseBox(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene["MC_Box" + _loc1_]);
            _loc6_.OnOverlay = UIComponentsHintOnOver;
            _loc6_.OnOut = UIComponentsHintOnOut;
            _loc6_.OnGetBox = this.ProcessorOnItemUp;
            this.FUIBoxVect[_loc1_] = _loc6_;
            _loc1_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = HERO_FACE_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSimpleNinjia);
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
               _loc1_ = 0;
               while(_loc1_ < HERO_COUNT)
               {
                  if(this.FHeroActive[_loc1_])
                  {
                     this.FHeroActive[_loc1_].UpdateActive();
                  }
                  if(this.FHeroRoleModel[_loc1_] != null)
                  {
                     TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroList[_loc1_].MC_Hero["heroHead"],CONST_MODULES.ACTIVE_Test,this.FHeroRoleModel[_loc1_].RoleHead);
                  }
                  _loc1_++;
               }
               _loc1_ = 0;
               while(_loc1_ < BOX_COUNT)
               {
                  if(this.FUIBoxVect[_loc1_])
                  {
                     this.FUIBoxVect[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateHero();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaMeeting.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaMeeting.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FNinjaMeeting.ActivityDesc;
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FNinjaMeeting.ActivityTabName,this.FNinjaMeeting.Score);
         FMC_Scene.TF_Desc2.text = this.FNinjaMeeting.ActivityDesc3;
         FMC_Scene.TF_Count.text = this.FNinjaMeeting.Score.toString();
         FMC_Scene.TF_Money.text = this.FNinjaMeeting.Money.toString();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            if(_loc1_ < this.FNinjaMeeting.BoxList.length)
            {
               _loc4_ = this.FNinjaMeeting.BoxList[_loc1_];
               this.FUIBoxVect[_loc1_].UpdateUI(_loc4_.Inventories);
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc4_.Count - _loc4_.BuyCount);
               this.FUIBoxVect[_loc1_].SetLimitText(_loc5_);
               _loc5_ = _loc4_.Price.toString();
               this.FUIBoxVect[_loc1_].SetPriceText(_loc5_);
               this.FUIBoxVect[_loc1_].SetCurPriceText(_loc4_.CurPrice.toString());
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_DISCOUNT_Str,_loc4_.Discount);
               this.FUIBoxVect[_loc1_].SetBuff(true,_loc5_);
               if(_loc4_.BuyCount >= _loc4_.Count)
               {
                  this.FUIBoxVect[_loc1_].SetBtnMode(false);
                  this.FUIBoxVect[_loc1_].IsBoxGot(true);
               }
               else if(this.FNinjaMeeting.Score >= _loc4_.Price)
               {
                  this.FUIBoxVect[_loc1_].SetBtnMode(true);
                  this.FUIBoxVect[_loc1_].IsBoxGot(false);
               }
               else
               {
                  this.FUIBoxVect[_loc1_].SetBtnMode(false);
                  this.FUIBoxVect[_loc1_].IsBoxGot(false);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TBaseHero = null;
         var _loc7_:TActive = null;
         var _loc8_:TBaseBox = null;
         var _loc9_:TRoleModel = null;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < HERO_BODY_COUNT)
         {
            _loc5_ = this.FHeroList[_loc1_];
            _loc2_ = _loc1_;
            _loc8_ = this.FNinjaMeeting.HeroList[_loc2_];
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc8_.Identify) as TBaseHero;
            _loc11_ = Math.min(_loc8_.Count,this.FNinjaMeeting.Score);
            if(_loc8_.PicType == HERO_TYPE_ALL)
            {
               _loc7_ = this.FHeroActive[_loc1_];
               _loc5_.TF_Name.text = _loc6_.Name;
               this.FTextFormat.color = QUALITYCOLOR_INDEX[_loc6_.Quality];
               _loc5_.TF_Name.setTextFormat(this.FTextFormat);
               _loc5_.TF_Cost.text = _loc8_.CurPrice;
               _loc5_.TF_CurCost.text = _loc8_.Price;
               _loc5_.TF_Desc.text = TUtilityString.Format(STRING_BASEACTIVITY.STRING_NINJAMEETING,_loc11_,_loc8_.Count);
               _loc10_ = uint(_loc8_.Identify);
               if(_loc7_ == null)
               {
                  _loc7_ = TPoolRole.GetActive(this,_loc10_,CONST_MODULES.ACTIVE_Test,false,false);
               }
               else
               {
                  _loc7_.ReloadRole();
               }
               _loc5_.MC_Hero.removeChildAt(0);
               _loc5_.MC_Hero.addChild(_loc7_);
               this.FHeroActive[_loc1_] = _loc7_;
            }
            else
            {
               _loc9_ = this.FHeroRoleModel[_loc1_];
               _loc5_.TF_Cost.text = _loc8_.CurPrice;
               _loc5_.TF_CurCost.text = _loc8_.Price;
               _loc5_.TF_Desc.text = TUtilityString.Format(STRING_BASEACTIVITY.STRING_NINJAMEETING,_loc11_,_loc8_.Count);
               if(_loc9_ == null)
               {
                  _loc9_ = this.FRoleModel.GetDatebaseByIdentifier(_loc8_.Identify) as TRoleModel;
                  this.FHeroRoleModel[_loc1_] = _loc9_;
               }
               TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,_loc5_.MC_Hero["heroHead"],CONST_MODULES.ACTIVE_Test,_loc9_.RoleHead);
            }
            if(_loc8_.Status == TNewYear.STATUS_ISGOT)
            {
               _loc5_.MC_Got2.visible = true;
               _loc5_.MC_Got.visible = false;
               _loc5_.BTN_Recruit.visible = false;
            }
            else if(_loc8_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc5_.MC_Got2.visible = false;
               _loc5_.MC_Got.visible = true;
               _loc5_.BTN_Recruit.visible = false;
            }
            else
            {
               _loc5_.MC_Got2.visible = false;
               _loc5_.MC_Got.visible = false;
               _loc5_.BTN_Recruit.visible = true;
               TGameUtil.setButtonMode(_loc5_.BTN_Recruit,true);
            }
            _loc1_++;
         }
         this.FUIPage.TotalQuantity = this.FNinjaMeeting.HeroList.length - HERO_BODY_COUNT;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < HERO_FACE_COUNT)
         {
            _loc5_ = this.FHeroList[_loc1_ + HERO_BODY_COUNT];
            _loc2_ = _loc1_ + HERO_BODY_COUNT + this.FCurPage * HERO_FACE_COUNT;
            if(_loc2_ < this.FNinjaMeeting.HeroList.length)
            {
               _loc5_.visible = true;
               _loc8_ = this.FNinjaMeeting.HeroList[_loc2_];
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc8_.Identify) as TBaseHero;
               _loc11_ = Math.min(_loc8_.Count,this.FNinjaMeeting.Score);
               if(_loc8_.PicType == HERO_TYPE_ALL)
               {
                  _loc7_ = this.FHeroActive[_loc1_ + HERO_BODY_COUNT];
                  _loc5_.TF_Name.text = _loc6_.Name;
                  this.FTextFormat.color = QUALITYCOLOR_INDEX[_loc6_.Quality];
                  _loc5_.TF_Name.setTextFormat(this.FTextFormat);
                  _loc5_.TF_Cost.text = _loc8_.CurPrice;
                  _loc5_.TF_CurCost.text = _loc8_.Price;
                  _loc5_.TF_Desc.text = TUtilityString.Format(STRING_BASEACTIVITY.STRING_NINJAMEETING,_loc11_,_loc8_.Count);
                  _loc10_ = uint(_loc8_.Identify);
                  if(_loc7_ == null)
                  {
                     _loc7_ = TPoolRole.GetActive(this,_loc10_,CONST_MODULES.ACTIVE_Test,false,false);
                  }
                  else
                  {
                     _loc7_.ReloadRole();
                  }
                  _loc5_.MC_Hero.removeChildAt(0);
                  _loc5_.MC_Hero.addChild(_loc7_);
                  this.FHeroActive[_loc1_ + HERO_BODY_COUNT] = _loc7_;
               }
               else
               {
                  _loc9_ = this.FHeroRoleModel[_loc1_ + HERO_BODY_COUNT];
                  _loc5_.TF_Cost.text = _loc8_.CurPrice;
                  _loc5_.TF_CurCost.text = _loc8_.Price;
                  _loc5_.TF_Desc.text = TUtilityString.Format(STRING_BASEACTIVITY.STRING_NINJAMEETING,_loc11_,_loc8_.Count);
                  if(_loc9_ == null)
                  {
                     _loc9_ = this.FRoleModel.GetDatebaseByIdentifier(_loc8_.Identify) as TRoleModel;
                     this.FHeroRoleModel[_loc1_ + HERO_BODY_COUNT] = _loc9_;
                  }
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,_loc5_.MC_Hero["heroHead"],CONST_MODULES.ACTIVE_Test,_loc9_.RoleHead);
               }
               if(_loc8_.Status == TNewYear.STATUS_ISGOT)
               {
                  _loc5_.MC_Got2.visible = true;
                  _loc5_.MC_Got.visible = false;
                  _loc5_.BTN_Recruit.visible = false;
               }
               else if(_loc8_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc5_.MC_Got2.visible = false;
                  _loc5_.MC_Got.visible = true;
                  _loc5_.BTN_Recruit.visible = false;
               }
               else
               {
                  _loc5_.MC_Got2.visible = false;
                  _loc5_.MC_Got.visible = false;
                  _loc5_.BTN_Recruit.visible = true;
                  TGameUtil.setButtonMode(_loc5_.BTN_Recruit,true);
               }
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ResetActive() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            if(this.FHeroRoleModel[_loc1_])
            {
               this.FHeroRoleModel[_loc1_] = null;
            }
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.ResetActive();
         this.UpdateHero();
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < HERO_BODY_COUNT)
         {
            _loc3_ = _loc2_;
         }
         else
         {
            _loc3_ = _loc2_ + this.FCurPage * HERO_FACE_COUNT;
         }
         if(_loc3_ < this.FNinjaMeeting.HeroList.length)
         {
            this.FOverlayerSimpleNinjia.Context = this.FNinjaMeeting.HeroList[_loc3_];
            this.FOverlayerSimpleNinjia.Render(FUICore.MouseCoordinate);
            this.FOverlayerSimpleNinjia.Show();
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         this.FOverlayerSimpleNinjia.Hide();
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < HERO_BODY_COUNT)
         {
            _loc3_ = _loc2_;
         }
         else
         {
            _loc3_ = _loc2_ + this.FCurPage * HERO_FACE_COUNT;
         }
         if(_loc3_ >= this.FNinjaMeeting.HeroList.length)
         {
            return;
         }
         this.FProcessorWindowRecruit.SetHeroData(uint(this.FNinjaMeeting.HeroList[_loc3_].Identify));
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         this.FConfirmType = TYPE_EXCHANGE_HERO;
         _loc5_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc5_ < HERO_BODY_COUNT)
         {
            FIndex = _loc5_;
         }
         else
         {
            FIndex = _loc5_ + this.FCurPage * HERO_FACE_COUNT;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            _loc2_ = this.FNinjaMeeting.HeroList[FIndex].Count;
            this.FCost = this.FNinjaMeeting.HeroList[FIndex].CurPrice;
            if(this.FNinjaMeeting.Score == 0)
            {
               this.FCostGold = this.FCost = this.FNinjaMeeting.HeroList[FIndex].Price;
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCostGold);
            }
            else if(this.FNinjaMeeting.Score >= _loc2_)
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(this.FNinjaMeeting.ActivityDesc2,_loc2_,this.FCost);
            }
            else
            {
               this.FCost = this.FNinjaMeeting.HeroList[FIndex].Price - this.FNinjaMeeting.Score;
               FUIWindowConfirmation.Text = TUtilityString.Format(this.FNinjaMeeting.ActivityDesc2,this.FNinjaMeeting.Score,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(false);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:Vector.<int> = null;
         if(this.FNinjaMeeting.IsMoneyEnough(this.FCost))
         {
            this.FBeClicked = true;
            _loc2_ = new Vector.<int>();
            _loc2_.push(FIndex + 1);
            switch(this.FConfirmType)
            {
               case TYPE_EXCHANGE_HERO:
                  PerformPacket_CS_AllReq(TYPE_EXCHANGE_HERO,_loc2_);
                  break;
               case TYPE_EXCHANGE_ITEM:
                  PerformPacket_CS_AllReq(TYPE_EXCHANGE_ITEM,_loc2_);
            }
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnItemUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         this.FConfirmType = TYPE_EXCHANGE_ITEM;
         FIndex = int(String(param1.currentTarget.parent.name).slice(6));
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = 0;
            this.FCostVouchers = this.FNinjaMeeting.BoxList[FIndex].Price;
            FUIWindowConfirmation.Text = TUtilityString.Format(this.FNinjaMeeting.ActivityName,this.FCostVouchers);
            FUIWindowConfirmation.SetCheckBox(false);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
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
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerNinjaMeeting.Unstreamize(_loc2_,this.FNinjaMeeting,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
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
         var _loc13_:Vector.<uint> = null;
         var _loc14_:uint = 0;
         var _loc15_:TBaseBox = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         switch(_loc7_)
         {
            case TYPE_EXCHANGE_HERO:
               _loc2_.readShort();
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNinjaMeeting.Score = _loc2_.readUnsignedInt();
               this.FNinjaMeeting.Money = _loc2_.readUnsignedInt();
               this.FNinjaMeeting.HeroList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               ProcessorEffectText(_loc4_);
               this.UpdateUI();
               break;
            case TYPE_EXCHANGE_ITEM:
               _loc2_.readShort();
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNinjaMeeting.Score = _loc2_.readUnsignedInt();
               this.FNinjaMeeting.Money = _loc2_.readUnsignedInt();
               _loc8_ = this.FNinjaMeeting.BoxList[_loc5_].Inventories;
               ++this.FNinjaMeeting.BoxList[_loc5_].BuyCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([0,0,0,1,1,1,1,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动1");
         TUtilityString.FlushUTF(_loc3_,"活动2");
         TUtilityString.FlushUTF(_loc3_,"活动3");
         _loc3_.writeInt(1);
         _loc3_.writeInt(14100001);
         _loc3_.writeShort(8);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(11110001 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            _loc3_.writeInt(10);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            TUtilityString.FlushUTF(_loc3_,"bbb");
            TUtilityString.FlushUTF(_loc3_,"ccc");
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(20);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

