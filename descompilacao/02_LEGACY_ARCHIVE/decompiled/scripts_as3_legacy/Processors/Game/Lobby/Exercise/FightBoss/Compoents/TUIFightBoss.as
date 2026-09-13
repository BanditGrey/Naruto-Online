package Processors.Game.Lobby.Exercise.FightBoss.Compoents
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Exercise.FightBoss.TFightBoss;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.FightBoss.TProcessorFightBoss;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIFightBoss extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const GIFT_COUNT:int = 5;
      
      protected static const HERO_COUNT:int = 2;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      public static const MOVIE_TYPE_BEAT_BOSS:int = 1;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 2;
      
      public static const MOVIE_TYPE_REFRESH_BOSS:int = 3;
      
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
      
      protected var FFightBoss:TFightBoss;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FGiftList:Vector.<TUIBaseBox>;
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FHeadBitmapVect:Vector.<Bitmap>;
      
      protected var FHeadIconList:Vector.<uint>;
      
      protected var FHeadIconType:Vector.<int>;
      
      protected var FTextFormat:TextFormat;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FMovieType:int;
      
      protected var FArticleBins:TBins;
      
      public function TUIFightBoss(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FGiftList = new Vector.<TUIBaseBox>(GIFT_COUNT);
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
         this.FHeadBitmapVect = new Vector.<Bitmap>(HERO_COUNT);
         this.FHeadIconList = new Vector.<uint>(HERO_COUNT);
         this.FHeadIconType = new Vector.<int>(HERO_COUNT);
         this.FTextFormat = new TextFormat();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.buttonMode = true;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Gift" + _loc2_]);
            _loc5_.OnOverlay = this.ProcessorOnGiftOver;
            _loc5_.OnOut = this.ProcessorOnGiftOut;
            _loc5_.OnGetBox = this.ProcessorOnGiftUp;
            this.FGiftList[_loc2_] = _loc5_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < HERO_COUNT)
         {
            param1 = FMC_Scene["MC_Hero" + _loc2_];
            this.FHeadBitmapVect[_loc2_] = new Bitmap();
            param1.MC_Hero.addChild(this.FHeadBitmapVect[_loc2_]);
            param1.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
            param1.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            TGameUtil.setButtonMode(param1.Btn_Get,true);
            param1.Btn_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
            TGameUtil.setButtonMode(param1.BTN_ShowDesc,true);
            param1.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
            this.FHeroList[_loc2_] = param1;
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.MC_Boss.BTN_Refresh,true);
         FMC_Scene.MC_Boss.BTN_Refresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnRefreshUp);
         FMC_Scene.MC_Boss.MC_Tip.buttonMode = true;
         FMC_Scene.MC_Boss.MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnBossUp);
         FMC_Scene.MC_Boss.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossOver);
         FMC_Scene.MC_Boss.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBossOut);
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Mask;
         if(this.FMC_Mask)
         {
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TBaseBox = null;
         _loc5_ = this.FFightBoss.BoxList[this.FFightBoss.BoxList.length - 1];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FFightBoss.BoxList.length)
            {
               _loc4_ = this.FFightBoss.BoxList[_loc1_];
               _loc3_.MC_Count.TF_Count.text = "*" + (_loc4_.Price + (this.FFightBoss.Round - 1) * _loc5_.Price);
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_CanGet.visible = true;
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
               }
               else
               {
                  _loc3_.MC_CanGet.visible = false;
                  _loc3_.MC_BoxPic.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            if(_loc1_ < this.FFightBoss.GiftList.length)
            {
               _loc4_ = this.FFightBoss.GiftList[_loc1_];
               this.FGiftList[_loc1_].UpdateUI(_loc4_.Inventories);
               _loc5_ = _loc4_.Title;
               this.FGiftList[_loc1_].SetDescText(0,_loc5_);
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  this.FGiftList[_loc1_].SetBtnMode(false);
                  this.FGiftList[_loc1_].IsBoxGot(false);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  this.FGiftList[_loc1_].SetBtnMode(true);
                  this.FGiftList[_loc1_].IsBoxGot(false);
               }
               else
               {
                  this.FGiftList[_loc1_].SetBtnMode(false);
                  this.FGiftList[_loc1_].IsBoxGot(true);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TRoleModel = null;
         var _loc6_:TBaseHero = null;
         var _loc7_:TBB_Status = null;
         var _loc8_:TInventory = null;
         var _loc9_:TArticle = null;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc3_ = this.FHeroList[_loc1_];
            if(_loc1_ < this.FFightBoss.HeroList.length)
            {
               _loc4_ = this.FFightBoss.HeroList[_loc1_];
               if(_loc3_.TF_Cost)
               {
                  _loc3_.TF_Cost.text = "*" + _loc4_.Price;
               }
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_Got2.visible = false;
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,true);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Got2.visible = false;
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,false);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.MC_Got2.visible = false;
                  _loc3_.MC_Got.visible = true;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,false);
               }
               else
               {
                  _loc3_.MC_Got2.visible = true;
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,false);
               }
               if(_loc4_.Type == TBaseBox.TYPE_IS_HERO)
               {
                  _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc4_.Identify) as TBaseHero;
                  _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc4_.Identify) as TRoleModel;
                  this.FHeadIconList[_loc1_] = _loc5_.RoleHead;
                  this.FHeadIconType[_loc1_] = TGameUtil.Type_HeadIcon;
                  _loc3_.TF_Name.text = _loc6_.Name;
                  this.FTextFormat.color = QUALITYCOLOR_INDEX[_loc6_.Quality];
                  _loc3_.TF_Name.setTextFormat(this.FTextFormat);
                  _loc3_.MC_BoxPic.visible = false;
               }
               else if(_loc4_.Type == TBaseBox.TYPE_IS_PET)
               {
                  _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc4_.Identify) as TBB_Status;
                  this.FHeadIconList[_loc1_] = _loc7_.SmPic;
                  this.FHeadIconType[_loc1_] = TGameUtil.Type_Pet;
                  _loc3_.TF_Name.text = _loc7_.Name;
                  this.FTextFormat.color = QUALITYCOLOR_INDEX[_loc7_.Rarity];
                  _loc3_.TF_Name.setTextFormat(this.FTextFormat);
                  _loc3_.MC_BoxPic.visible = false;
               }
               else
               {
                  _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc4_.Identify) as TArticle;
                  _loc3_.MC_BoxPic.visible = true;
                  this.FHeadIconList[_loc1_] = 0;
                  this.FHeadIconType[_loc1_] = -1;
                  _loc3_.TF_Name.text = STRING_COMMON.GetItemNameByType(1,_loc4_.Identify);
                  this.FTextFormat.color = QUALITYCOLOR_INDEX[_loc9_.Quality];
                  _loc3_.TF_Name.setTextFormat(this.FTextFormat);
               }
               if(_loc1_ == 1)
               {
                  _loc3_.Btn_Get.visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBoss() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FFightBoss.LimitCount == 0)
         {
            FMC_Scene.MC_Boss.BTN_Refresh.visible = false;
            FMC_Scene.MC_Boss.MC_KillMovie.visible = false;
            FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            FMC_Scene.MC_Boss.MC_Click.visible = false;
            FMC_Scene.MC_AllBeat.visible = true;
         }
         else if(this.FFightBoss.CurHP == 0)
         {
            FMC_Scene.MC_Boss.BTN_Refresh.visible = true;
            FMC_Scene.MC_Boss.MC_KillMovie.visible = true;
            _loc1_ = int(FMC_Scene.MC_Boss.MC_KillMovie.totalFrames);
            FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(_loc1_);
            FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            FMC_Scene.MC_Boss.MC_Click.visible = false;
            FMC_Scene.MC_AllBeat.visible = false;
         }
         else
         {
            FMC_Scene.MC_Boss.BTN_Refresh.visible = false;
            FMC_Scene.MC_Boss.MC_KillMovie.visible = true;
            FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(1);
            FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            FMC_Scene.MC_Boss.MC_Click.visible = true;
            FMC_Scene.MC_AllBeat.visible = false;
         }
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FFightBoss.CurHP + "/" + this.FFightBoss.MaxHP;
         _loc2_ = Number(this.FFightBoss.CurHP / this.FFightBoss.MaxHP) * this.FBarMaxWidth;
         _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc3_});
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FFightBoss.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FFightBoss.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FFightBoss.ActivityName;
         FMC_Scene.TF_Count.text = "*" + this.FFightBoss.Score.toString();
         FMC_Scene.TF_FreeCount.text = this.FFightBoss.FreeCount.toString();
         FMC_Scene.TF_LimitCount.text = this.FFightBoss.LimitCount.toString();
         FMC_Scene.TF_KillCount.text = this.FFightBoss.Count.toString();
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         if(Boolean(this.FFightBoss) && Boolean(this.FFightBoss.HeroList.length > 0) && Boolean(this.FHeroList[0]))
         {
            _loc1_ = 0;
            while(_loc1_ < HERO_COUNT)
            {
               if(this.FHeadIconType[_loc1_] >= 0)
               {
                  this.FHeroList[_loc1_].MC_Hero.x = 8 + (89 - this.FHeadBitmapVect[_loc1_].width) / 2;
                  this.FHeroList[_loc1_].MC_Hero.y = 10 + (79 - this.FHeadBitmapVect[_loc1_].height) / 2;
                  TGameUtil.ShowImageByID(this.FHeadIconType[_loc1_],this.FHeadBitmapVect[_loc1_],CONST_MODULES.ACTIVE_Test,this.FHeadIconList[_loc1_]);
               }
               _loc1_++;
            }
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FFightBoss) && _loc2_ < this.FFightBoss.BoxList.length)
         {
            if(this.FFightBoss.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorFightBoss.ACTIVITY_1_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null) && Boolean(this.FFightBoss) && _loc2_ < this.FFightBoss.GiftList.length)
         {
            if(this.FFightBoss.GiftList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorFightBoss.ACTIVITY_1_GET_GIFT,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null) && Boolean(this.FFightBoss) && this.FFightBoss.HeroList.length > 0)
         {
            if(this.FFightBoss.HeroList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorFightBoss.ACTIVITY_1_GET_HERO,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBossUp(param1:MouseEvent) : void
      {
         if(this.FFightBoss.CurHP <= 0 || FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FFightBoss))
         {
            if(this.FFightBoss.FreeCount > 0)
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorFightBoss.ACTIVITY_1_KILL_BOSS,0,0,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorFightBoss.ACTIVITY_1_KILL_BOSS,this.FFightBoss.Cost,0,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      protected function ProcessorOnRefreshUp(param1:MouseEvent) : void
      {
         if(this.FFightBoss.CurHP > 0 || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FFightBoss))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorFightBoss.ACTIVITY_1_REFRESH_BOSS);
         }
      }
      
      protected function ProcessorOnBossOver(param1:MouseEvent) : void
      {
         if(this.FFightBoss)
         {
            ProcessorOnShowHtmlTip(this.FFightBoss.ActivityDesc3);
         }
      }
      
      protected function ProcessorOnBossOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FFightBoss) && _loc2_ < this.FFightBoss.BoxList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightBoss.BoxList[_loc2_].Desc1);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnGiftOver(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.MC_Scene.name).slice(7));
         if(Boolean(this.FFightBoss) && _loc3_ < this.FFightBoss.BoxList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightBoss.GiftList[_loc3_].Desc1);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:Object, param2:Object) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FFightBoss) && _loc2_ < this.FFightBoss.HeroList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightBoss.HeroList[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FFightBoss) && Boolean(_loc2_ < this.FFightBoss.HeroList.length) && FOnShowRecruit != null)
         {
            FOnShowRecruit(this.FFightBoss.HeroList[_loc2_].Identify,this.FFightBoss.HeroList[_loc2_].Type);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               this.UpdataBitmap();
               _loc1_ = 0;
               while(_loc1_ < GIFT_COUNT)
               {
                  if(this.FGiftList[_loc1_])
                  {
                     this.FGiftList[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
               if(FIsPlaying)
               {
                  if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
                  {
                     CurFrame = FMC_Scene.MC_Boss.MC_BeatMovie.currentFrame;
                  }
                  else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
                  {
                     CurFrame = FMC_Scene.MC_Boss.MC_KillMovie.currentFrame;
                  }
                  else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
                  {
                     CurFrame = FMC_Scene.MC_Boss.MC_RefreshMovie.currentFrame;
                  }
                  if(CurFrame >= FTotalFrame)
                  {
                     FIsPlaying = false;
                     this.MovieEnd();
                  }
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FFightBoss = SLogicsCore.FightBossDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TFightBoss;
         this.UpdateBox();
         this.UpdateGift();
         this.UpdateHero();
         this.UpdateBoss();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            _loc5_ = FMC_Scene.MC_Boss.MC_BeatMovie;
            _loc5_.visible = true;
            FMC_Scene.MC_Boss.MC_KillMovie.visible = false;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            _loc5_ = FMC_Scene.MC_Boss.MC_KillMovie;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.visible = true;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
         {
            _loc5_ = FMC_Scene.MC_Boss.MC_RefreshMovie;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.visible = true;
            _loc5_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            if(this.FFightBoss.CurHP == 0)
            {
               this.PlayMovie(MOVIE_TYPE_BOSS_DIED);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
         {
            this.UpdateUI();
         }
      }
   }
}

