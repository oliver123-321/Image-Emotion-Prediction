# Image-Emotion-Prediction

The goal of this project was to see if a model can learn something so human-subjective, like emotions, and how well it can learn it. <br/>
Coming from a cognitive science background, there's this age old question of can robots truly have consciousness, and can they truly have "feelings"?  
I wanted to see what it would be like to implement this by creating a model to predict emotions from pictures. <br/> 
Here is a short 3-minutes video on the project: https://www.loom.com/share/1917bb5ed8f14eec8eb16a9b7e7dbac4

I used two datasets, both from emotion studies.
One is called the Geneva affective picture database (GAPED). <br/>
Link to study: https://link.springer.com/article/10.3758/s13428-011-0064-1 <br/>
Link to dataset: https://www.unige.ch/cisa/research/materials-and-online-research/research-material/

The other is The Nencki Affective Picture System (NAPS).
Link to study: https://link.springer.com/article/10.3758/s13428-013-0379-1 <br/>
Link to dataset: https://lobi.nencki.gov.pl/research/8/

## General info
The GAPED dataset comes with 730 images, and csv files that have emotional ratings for each type of image in the dataset.
The images were broken up into 6 types.

There were four specific negative content: <br/>
**A:** Animal mistreatment<br/>
**H:** Human rights violation<br/>
**Sn:** Snakes <br/>
**Sp:** Spiders<br/>

**Positive** images contain: Human and animal babies, and nature sceneries <br/>
**Neutral** images contain: Inanimate objects

Each image had some emotion ratings:<br/>
**Valence:** how negative to how positive the image was. 0 = very negative to 100 = very positive, with 50 = neutral.<br/>
**i.e:** “You are judging this image as …”, from negative to positive.<br/>
**Arousal:** degree of arousal elicited by the picture.<br/>
**i.e:** “Confronted with this image you are feeling: …”, on two scales: from Calm to Excited, and from Stimulated to Relaxed.<br/>
**Internal norms:** whether the contents of the picture were morally and ethically acceptable (only applicable to animal mistreatment and human rights violation images)<br/>
**External norms:** whether the contents of the picture were legally acceptable (only applicable to animal mistreatment and human rights violation images)

The column of interest is the valence scores associated with each image. However, the distribution of the valence scores is highly imbalanced. <br/>
![](Images/Valence%20Rating%20by%20Valence%20Category.png)

This is due to the image set being imbalanced in the types of images it contains: <br/>
![](Images/Class%20Imbalance.png)

This becomes an issue as the model will predict most images as having more negative scores, particulary around 30-60. This is on top of having a very small image set, where the model has little examples to learn from. The class imbalance will also reflect a false accuracy when doing a classification problem, so it is important to compare the precision and recall in this case as well.

What is important to note is that the calculated valence category based on valence score does not necessarily reflect the labeled valence category. Looking at the negative category, some images have scores above 50. This may lead to false positives (positive in the negative sense) in the labeled negative valence category. It could also reflect some subjectiveness in the interpretation the image. A type of image may be associated with negative emotions, but it may not be considered so negative by every single person. What the distribution of valence scores shows is that image sentiment analysis using objective classification methods may not necessarily reflect the subjective valence rating associated with each image. A hard threshold for what is considered negative, neutral, and positive may not capture variations in interpretations. <br/>
However, by teaching the model that certain types of images can contain both positive and negative valence examples, the model can become more robust to accounting for variations in images that tend to fall under one particular valence category. The training for a classification problem should thus, be done based on calculated valence category, rather than the labeled valence category.

Since the valence score is a value, a CNN with a single-node linear output is created. <br/>
This project is intended to be a 2-step process however:

The first is to create a model that can predict the valence score associated with each image, then use the output of that model to predict and classify what valence category each image belongs in. <br/>
If I only did regression, all the model will be doing is predicting some value associated with each image. The model would have never actually learned any relationship amongst the images, and the interpretation of the emotional valence category will only be coming from us humans. 
However, by having the model use the outputs of its predictions as inputs for a classification problem, it has to learn why certain images are rated between a certain range of valence.  <br/>
To implement a 2-step problem though, the model has to be able to make good predictions in the first step to be able to move on to the second step, which is where I am currently stuck on so far.
 
## Setup
Using CNNs from Keras applications allowed me to see how different models fared on the regression task. I used five pre-trained models: InceptionV3, MobileNet, Resnet50, VGG19, and Xception. <br/>
At first, all coding was done in a Jupyter Notebook, but the kernel always died when running the VGG19 model. Eventually, all coding was moved to Google Colab, as Colab also has GPU available for use, which rapidly increased the speed of training. <br/>
Sometimes I ran into a ParserError when reading in csv files however, and it did go away after I restarted the notebooks after awhile, but it is something to look out for. Some have said that this error seems to occur when reading in too much data in a short period of time. 

## Training
A lot of hyperparameter optimization was done on the MobileNet model, as it is the smallest model to work with. The best parameters from the model were applied to other pre-trained models.
At some point though, even with tweaking and testing, the models got stuck and could not improve any further. <br/>
There were the best results that I could get for each model: <br/>
![](Images/Best%20Results.png)

With the R2 score being negative, and the mean squared error being in the hundreds, I realized that even with more tweaking, I would probably not be able to improve the model's performance any further.
I realized that I needed to address the root of the problem, which is the image set that I was working with. At the time of making the project, I didn't have time to address the image set issues. This is something that I am currently working to address now.

## Examples
Valence scale: <br/>
![](Images/Valence%20Scale.png)

What my best performing model predicts for a positive image:
![](Images/Positive%20Image%20Demo.png)

Neutral image:
![](Images/Neutral%20Image%20Demo.png)

Negative image:
![](Images/Negative%20Image%20Demo.png)

As it can be seen, the best optimized model is predicting the images to have scores around 39, which matches the imbalance in the image set, since a majority of images had scores between 30-40. 

## To-do list:
1. NAPS EDA: NAPS is another image set that also contain images with emotion measures. It also comes with a dataset that contains information about each image, such as the emotion measures, and physical properties about each image.
The goal is ultimately address the class imbalance in the image set, as well as ensuring that each class has a large enough sample to work from.
2. Train the images based on the calculated valence category, not the labeled valence category.
3. Hyperparameter optimization of the regression CNN model. 
4. Create a CNN classifier that can take 2 inputs: one being the image arrays, and the other being the output of the regression model. 

## Status
The project is still in status. 

## Contact
Created by Oliver Huang - feel free to reach out to me on LinkedIn or by email. <br/>
LinkedIn: https://www.linkedin.com/in/oliver-huang123/ <br/>
Email: fudo0024@hotmail.com

For more examples on image sentiment analysis, feel free to check out some of the studies below. <br/>
**Robust Image Sentiment Analysis Using Progressively Trained and Domain Transferred Deep Networks** <br/>
http://www.ifp.illinois.edu/~jyang29/papers/AAAI15-sentiment.pdf

**Emotion Detection and Sentiment Analysis of Images** <br/>
https://www.cc.gatech.edu/~hays/7476/projects/Aditi_Vasavi.pdf

For tips on CNN regression: <br/>
https://www.pyimagesearch.com/2019/01/28/keras-regression-and-cnns/

## References
Dan-Glauser, E.S., Scherer, K.R. The Geneva affective picture database (GAPED): a new 730-picture database focusing on valence and normative significance. Behav Res 43, 468 (2011). doi.org/10.3758/s13428-011-0064-1

Marchewka A., Żurawski Ł., Jednoróg K., Grabowska A. (2014) The Nencki Affective Picture System (NAPS): introduction to a novel, standardized, wide-range, high-quality, realistic picture database. Behavior Research Methods, 46(2), 596–610. doi:10.3758/s13428-013-0379-1

Riegel M., Żurawski Ł., Wierzba M., Moslehi A., Klocek Ł., Horvat M., Grabowska A., Michalowski J. Jednoróg K., Marchewka A. (2016) Characterization of the Nencki Affective Picture System by discrete emotional categories (NAPS BE). Behavior Research Methods, 48(2), 600-612. doi:10.3758/s13428-015-0620-1

Wierzba M., Riegel M., Pucz A., Leśniewska Z., Dragan W. Ł., Gola M., Jednoróg K., Marchewka A. (2015) Erotic subset for the Nencki Affective Picture System (NAPS ERO): cross-sexual comparison study. Frontiers in Psychology, 6:1336. doi: 10.3389/fpsyg.2015.01336

Michałowski J. M., Droździel D., Matuszewski J., Koziejowski W., Jednoróg K., Marchewka A. (2016) Set of Fear Inducing Pictures (SFIP): The development and validation in fearful and non-fearful individuals. Behavior Research Methods, doi:10.3758/s13428-016-0797-y
