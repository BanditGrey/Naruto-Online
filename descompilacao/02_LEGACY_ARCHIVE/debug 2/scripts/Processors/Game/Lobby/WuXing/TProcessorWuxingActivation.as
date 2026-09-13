package Processors.Game.Lobby.WuXing
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Logics.WuXing.TWuXing;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_WUXING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWuxingActivation extends TProcessorLobbyWindow
   {
      
      protected var HERO_COUNT:int = 10;
      
      protected var heros:THeros;
      
      protected var heronumer:int;
      
      protected var heroBmp:Bitmap;
      
      protected var FMC_PIC:MovieClip;
      
      protected var FBtn_reset:MovieClip;
      
      protected var FBtn_AddPoint:SimpleButton;
      
      protected var FTF_Maxpoint:TextField;
      
      protected var FTF_Point:TextField;
      
      protected var HERO_COUNT_Vec:Vector.<MovieClip>;
      
      protected var HERO_Vec:Vector.<THero>;
      
      protected var cur_hero_index:int;
      
      protected var cur_page_index:int = 1;
      
      protected var all_page_index:int = 1;
      
      protected var F_Cur_Hero:THero;
      
      protected var FMCWuxingActivation:MovieClip;
      
      protected const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected const ELE_TYPE:Array = CONST_WUXING.ELE_TYPE;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWuxingUintVec:Array;
      
      protected var FWuXingData:Vector.<TWuXing>;
      
      protected var FWuXing:TWuXing;
      
      protected var FResetNeedCost:int;
      
      protected var FSkilCardId:int;
      
      protected var FTFLevelList:Array = new Array();
      
      public var OnActivateClick:Function;
      
      public var OnAddPointClick:Function;
      
      public function TProcessorWuxingActivation(param1:TUIComponent)
      {
         super(param1);
         this.HERO_COUNT_Vec = new Vector.<MovieClip>();
         this.FUIWuxingUintVec = new Array();
      }
      
      public function Initiliation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIWuxingUint = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TConfigValue = null;
         this.FMCWuxingActivation = TProcessorWuxing(FParent).MC_WuxingActivation;
         this.FMC_PIC = this.FMCWuxingActivation.MC_Slot_Pic;
         this.FMC_PIC.scaleX = this.FMC_PIC.scaleY = 0.8;
         this.heroBmp = new Bitmap();
         this.FMC_PIC.IconMountPoint.addChild(this.heroBmp);
         this.FTF_Maxpoint = this.FMCWuxingActivation.TF_Maxpoint;
         this.FTF_Point = this.FMCWuxingActivation.TF_Point;
         this.FBtn_AddPoint = this.FMCWuxingActivation.Btn_AddPoint;
         _loc1_ = 0;
         while(_loc1_ < this.HERO_COUNT)
         {
            this.HERO_COUNT_Vec[_loc1_] = this.FMCWuxingActivation[CONST_WUXING.MC_HERONAME + _loc1_] as MovieClip;
            this.HERO_COUNT_Vec[_loc1_][CONST_WUXING.TF_HERONAME].mouseEnabled = false;
            this.HERO_COUNT_Vec[_loc1_][CONST_WUXING.TF_HEROLEVEL].mouseEnabled = false;
            this.HERO_COUNT_Vec[_loc1_].buttonMode = true;
            _loc1_++;
         }
         this.FBtn_reset = this.FMCWuxingActivation.Btn_Reset;
         TGameUtil.setButtonMode(this.FBtn_reset,true);
         this.herorelation();
         this.addEventLister();
         _loc1_ = 1;
         while(_loc1_ < this.ELE_TYPE.length)
         {
            _loc3_ = this.FMCWuxingActivation["MC_" + this.ELE_TYPE[_loc1_]];
            _loc2_ = new TUIWuxingUint(_loc3_,_loc1_);
            _loc2_.OnClickFunc = this.OnActivateClick;
            this.FUIWuxingUintVec.push(_loc2_);
            _loc4_ = this.FMCWuxingActivation["TF_Lv_" + _loc1_];
            this.FTFLevelList[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         this.FUIWindowConfirmation.OnOK = this.OnWindowConfirmationOk;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,93000003) as TConfigValue;
         this.FResetNeedCost = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,93000002) as TConfigValue;
         this.FSkilCardId = _loc5_.Value as uint;
      }
      
      protected function addEventLister() : void
      {
         var _loc1_:int = 0;
         this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageLeft"].addEventListener(MouseEvent.CLICK,this.onPageChange);
         this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageRight"].addEventListener(MouseEvent.CLICK,this.onPageChange);
         _loc1_ = 0;
         while(_loc1_ < this.HERO_COUNT)
         {
            this.HERO_COUNT_Vec[_loc1_].addEventListener(MouseEvent.CLICK,this.heroClick);
            this.HERO_COUNT_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.heroout);
            this.HERO_COUNT_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.heroOver);
            _loc1_++;
         }
         this.FBtn_reset.addEventListener(MouseEvent.CLICK,this.onResetClick);
         this.FBtn_AddPoint.addEventListener(MouseEvent.CLICK,this.onClickAddpoint);
      }
      
      public function UpdateInterface(param1:Vector.<TWuXing>) : void
      {
         this.FWuXingData = param1;
         this.FWuXing = this.getWuxingByHeroId(this.FWuXingData);
         this.UdateCurHeroProperty();
         this.updateElementInfo(this.FWuXing);
      }
      
      public function SynchronWuxingLevel(param1:int, param2:int) : void
      {
         var _loc3_:TextField = null;
         _loc3_ = this.FMCWuxingActivation["TF_Lv_" + (param2 + 1)];
         _loc3_.text = "LV " + param1;
      }
      
      protected function getWuxingByHeroId(param1:Vector.<TWuXing>) : TWuXing
      {
         var _loc2_:int = 0;
         var _loc3_:TWuXing = null;
         if(param1)
         {
            for each(_loc3_ in param1)
            {
               if(Boolean(this.F_Cur_Hero) && _loc3_.heroId == this.F_Cur_Hero.Identifier)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      protected function updateElementInfo(param1:TWuXing) : void
      {
         var _loc2_:TUIWuxingUint = null;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         if(this.FUIWuxingUintVec)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FUIWuxingUintVec.length)
            {
               _loc2_ = this.FUIWuxingUintVec[_loc3_];
               _loc2_.upWuxingInfo(param1);
               _loc3_++;
            }
         }
         if(param1)
         {
            this.FTF_Point.text = param1.ElementPoint.toString();
         }
      }
      
      protected function herorelation() : void
      {
         var _loc2_:int = 0;
         this.heros = SLogicsCore.Character.Heros;
         this.heros = this.selectFromHeros(this.heros);
         if(this.heros.Count == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.HERO_COUNT)
            {
               this.HERO_COUNT_Vec[_loc2_].visible = false;
               _loc2_++;
            }
            return;
         }
         this.F_Cur_Hero = this.heros.GetHeroByIndex(this.cur_hero_index);
         this.heronumer = this.heros.Count;
         this.all_page_index = Math.ceil(this.heronumer / this.HERO_COUNT);
         var _loc1_:int = 0;
         while(_loc1_ < this.HERO_COUNT)
         {
            if(_loc1_ + (this.cur_page_index - 1) * this.HERO_COUNT > this.heronumer - 1)
            {
               this.HERO_COUNT_Vec[_loc1_].visible = false;
            }
            else
            {
               this.onehero(this.heros.GetHeroByIndex(_loc1_ + (this.cur_page_index - 1) * this.HERO_COUNT),this.HERO_COUNT_Vec[_loc1_]);
               this.HERO_COUNT_Vec[_loc1_].visible = true;
            }
            _loc1_++;
         }
         this.setBtnState();
         TextField(this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["page"]).text = this.cur_page_index + "/" + this.all_page_index;
         this.for_hero_index();
         this.UdateCurHeroProperty();
      }
      
      protected function selectFromHeros(param1:THeros) : THeros
      {
         var _loc3_:THero = null;
         var _loc4_:TBaseHero = null;
         var _loc2_:THeros = new THeros();
         for each(_loc3_ in param1.Heros)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc3_.Identifier) as TBaseHero;
            if(_loc4_.Maxpoint > 0)
            {
               _loc2_.Add(_loc3_);
            }
         }
         return _loc2_;
      }
      
      protected function onehero(param1:THero, param2:MovieClip) : void
      {
         var _loc3_:uint = this.QUALITYCOLOR_INDEX[param1.Quality];
         TextField(param2["HeroName"]).textColor = _loc3_;
         TextField(param2["level"]).textColor = _loc3_;
         TextField(param2["HeroName"]).text = param1.Name;
         TextField(param2["level"]).text = param1.GetLevelStrByLevel(param1.Level);
      }
      
      protected function UdateCurHeroProperty() : void
      {
         if(this.F_Cur_Hero == null)
         {
            return;
         }
         var _loc1_:uint = this.QUALITYCOLOR_INDEX[this.F_Cur_Hero.Quality];
         TextField(this.FMC_PIC.HeroName).textColor = _loc1_;
         TextField(this.FMC_PIC.Level).textColor = _loc1_;
         TextField(this.FMC_PIC.HeroName).text = this.F_Cur_Hero.Name;
         TextField(this.FMC_PIC.Level).text = this.F_Cur_Hero.GetLevelStrByLevel(this.F_Cur_Hero.Level);
         this.FTF_Maxpoint.text = this.BaseHeroBin.Maxpoint.toString();
      }
      
      protected function pichero(param1:THero) : void
      {
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.heroBmp,CONST_MODULES.MODULE_NinJaPractice,param1.SmallID);
      }
      
      protected function for_hero_index() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.HERO_COUNT)
         {
            _loc2_ = this.HERO_COUNT_Vec[_loc1_].name;
            _loc3_ = int(_loc2_.charAt(_loc2_.length - 1)) + (this.cur_page_index - 1) * this.HERO_COUNT;
            if(_loc3_ == this.cur_hero_index)
            {
               this.HERO_COUNT_Vec[_loc1_].gotoAndStop(1);
            }
            else
            {
               this.HERO_COUNT_Vec[_loc1_].gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      protected function setBtnState() : void
      {
         if(this.all_page_index <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageLeft"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageRight"]),false);
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageLeft"]),this.cur_page_index == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageRight"]),this.cur_page_index >= this.all_page_index ? false : true);
         }
      }
      
      protected function heroClick(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
         var _loc2_:String = MovieClip(param1.target).name;
         this.cur_hero_index = int(_loc2_.charAt(_loc2_.length - 1)) + (this.cur_page_index - 1) * this.HERO_COUNT;
         this.F_Cur_Hero = this.heros.GetHeroByIndex(this.cur_hero_index);
         this.UpdateInterface(this.FWuXingData);
         this.for_hero_index();
      }
      
      protected function heroout(param1:MouseEvent) : void
      {
         var _loc2_:String = MovieClip(param1.target).name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1)) + (this.cur_page_index - 1) * this.HERO_COUNT;
         if(_loc3_ == this.cur_hero_index)
         {
            MovieClip(param1.target).gotoAndStop(1);
         }
         else
         {
            MovieClip(param1.target).gotoAndStop(2);
         }
      }
      
      protected function heroOver(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(3);
      }
      
      public function onPageChange(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageLeft"]:
               if(this.cur_page_index > 1)
               {
                  --this.cur_page_index;
                  this.herorelation();
               }
               break;
            case this.FMCWuxingActivation[CONST_WUXING.MC_HEROPAGE]["MC_PageRight"]:
               if(this.cur_page_index < this.all_page_index)
               {
                  this.cur_page_index += 1;
                  this.herorelation();
               }
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.F_Cur_Hero)
         {
            this.pichero(this.F_Cur_Hero);
         }
      }
      
      protected function get BaseHeroBin() : TBaseHero
      {
         var _loc1_:TBaseHero = null;
         return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.F_Cur_Hero.Identifier) as TBaseHero;
      }
      
      protected function onClickAddpoint(param1:MouseEvent) : void
      {
         if(!this.F_Cur_Hero)
         {
            return;
         }
         if(this.wuxingPointIsMax)
         {
            EffectGenerateText(new ConsumeFrame(80002353).DescribeString);
            return;
         }
         var _loc2_:int = int(SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FSkilCardId));
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Tag = 1;
         this.FUIWindowConfirmation.SetHtml = TUtilityString.Format(new ConsumeFrame(80002351).DescribeString,_loc2_);
      }
      
      protected function onResetClick(param1:MouseEvent) : void
      {
         if(!this.F_Cur_Hero)
         {
            return;
         }
         if(!this.IfResetWuxingPoint())
         {
            EffectGenerateText(new ConsumeFrame(80002356).DescribeString);
            return;
         }
         var _loc2_:int = int(SLogicsCore.Character.CreditGold);
         if(_loc2_ < this.FResetNeedCost)
         {
            EffectGenerateText(new ConsumeFrame(80002355).DescribeString);
            return;
         }
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Tag = 2;
         this.FUIWindowConfirmation.SetHtml = TUtilityString.Format(new ConsumeFrame(80002352).DescribeString,this.FResetNeedCost);
      }
      
      protected function OnWindowConfirmationOk(param1:Object) : void
      {
         if(this.FUIWindowConfirmation.Tag == 1)
         {
            this.OnAddPointClick(this.F_Cur_Hero.Identifier);
         }
         else
         {
            this.OnActivateClick(this.F_Cur_Hero.Identifier);
         }
      }
      
      protected function get wuxingPointIsMax() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 1;
         while(_loc4_ < this.ELE_TYPE.length)
         {
            _loc2_ = this.FWuXing.ElementBit >> _loc4_ & 1;
            if(_loc2_ == 1)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         if(_loc3_ >= this.BaseHeroBin.Maxpoint)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      protected function IfResetWuxingPoint() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 1;
         while(_loc4_ < this.ELE_TYPE.length)
         {
            _loc2_ = this.FWuXing.ElementBit >> _loc4_ & 1;
            if(_loc2_ == 1)
            {
               _loc1_ = true;
            }
            _loc4_++;
         }
         return _loc1_;
      }
   }
}

